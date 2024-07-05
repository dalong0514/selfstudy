## 2024028Scaling-Down-to-Scale-Up

arXiv:2303.15647

Scaling Down to Scale Up: A Guide to Parameter-Efficient Fine-Tuning

Vladislav Lialin, Vijeta Deshpande, Anna Rumshisky

### Abstract

This paper presents a systematic overview and comparison of parameter-efficient fine-tuning methods covering over 40 papers published between February 2019 and February 2023. These methods aim to resolve the infeasibility and impracticality of fine-tuning large language models by only training a small set of parameters. We provide a taxonomy that covers a broad range of methods and present a detailed method comparison with a specific focus on real-life efficiency and fine-tuning multibillion-scale language models.

本论文系统地概述和比较了参数高效微调（Parameter-Efficient Fine-Tuning，PEFT）方法，涵盖了 2019 年 2 月至 2023 年 2 月间发表的 40 多篇论文。这些方法旨在通过仅训练一小部分参数来解决大型语言模型（Large Language Model，LLM）微调过程中的技术难题和实际困境。我们提供了一个涵盖广泛方法的分类体系，并进行了详细的方法比较，特别关注实际应用效率和数十亿参数规模语言模型的微调过程。

### 01 Introduction

One thing that should be learned from the bitter lesson is the great power of general purpose methods, of methods that continue to scale with increased computation...
Rich Sutton, The Bitter Lesson

In October 2018, BERT Large (Devlin et al., 2019) with 350 million parameters was the biggest Transformer model (Vaswani et al., 2017) ever trained. At the time, contemporary hardware struggled to fine-tune this model. The section "Out-of-memory issues" on BERT's GitHub specifies the maximum batch size for BERT Large given 12Gb of GPU RAM and 512 tokens as zero. Four years in, publically available models grew up to 176 billion parameters (Scao et al., 2022; Zhang et al., 2022; Zeng et al., 2022), by a factor of 500. Published literature includes models up to 1 trillion parameters (Chowdhery et al., 2022; Shoeybi et al., 2019; Fedus et al., 2021). However, single-GPU RAM increased less than 10 times (to 80Gb) due to the high cost of HBM memory. Model size scales almost two orders of magnitude quicker than computational resources making fine-tuning the largest models to downstream tasks infeasible for most and impractical for everyone.

In-context learning (Radford et al., 2019) thus became the new normal, the standard way to pass downstream task training data to billion-scale language models. However, the limited context size of Transformers artificially limits the training set size to just a few examples, typically less than 100. This constraint, coupled with the absence of in-context learning performance guarantees even on the training data, presents a challenge. Additionally, expanding the context size leads to a quadratic increase in inference costs. Even though language models perform exceptionally well (Brown et al., 2020) in a few-shot scenario, "get more data" is still the most reliable way to improve on any given task. Thus, we, as a community of researchers and engineers, need efficient ways to train on downstream task data.

Parameter-efficient fine-tuning, which we denote as PEFT, aims to resolve this problem by only training a small set of parameters which might be a subset of the existing model parameters or a set of newly added parameters. These methods differ in parameter efficiency, memory efficiency, training speed, final quality of the model, and additional inference costs (if any). In the last few years, more than a hundred of PEFT papers have been published, with several studies (Ding et al., 2022) providing a good overview of the most popular methods, such as Adapters (Houlsby et al., 2019), BitFit (Ben-Zaken et al., 2021), LoRa (Hu et al., 2021), Compacter (Karimi Mahabadi et al., 2021), and Soft Prompts (Liu et al., 2021; Li and Liang, 2021). Recently, Pfeiffer et al. (2023) presented a survey on modular deep learning overviewing similar methods from the perspective of modularity and multi-task inference.

This survey presents a systematic overview, comparison, and taxonomy of 30 parameter-efficient fine-tuning methods with 20 methods discussed in-depth, covering over 40 papers published from February 2019 to February 2023. We highlight the current unresolved challenges in PEFT, including the limited theoretical understanding, the gap between PEFT and fine-tuning performance, and reporting issues. In conclusion, we suggest several avenues for improvement, such as developing standardized PEFT benchmarks, investigating novel reparameterization techniques with superior parameter-to-rank ratios, conducting in-depth studies on hyperparameters and interpretability, and drawing inspiration from on-device (edge) machine learning research.

1 引言

从「苦涩的教训」中我们应该学到的一件事是通用方法的巨大力量，即那些能够随着计算能力的增加而持续扩展的方法...

Rich Sutton，《The Bitter Lesson》

2018 年 10 月，拥有 3.5 亿参数的 BERT Large（Devlin et al.，2019）是当时训练过的最大的 Transformer 模型（Vaswani et al.，2017)。当时，现有的硬件很难对这个模型进行微调。BERT 的 GitHub 上 "内存溢出问题" 部分指出，在 12GB GPU 内存和 512 个 token 的条件下，BERT Large 的最大批处理大小为零。四年后，公开可用的模型参数量增长到 1760 亿（Scao et al.，2022; Zhang et al.，2022; Zeng et al.，2022)，增加了 500 倍。已发表的文献甚至包括高达 1 万亿参数的模型（Chowdhery et al.，2022; Shoeybi et al.，2019; Fedus et al.，2021)。然而，由于高带宽内存（High Bandwidth Memory，HBM）的高成本，单 GPU 内存仅增加了不到 10 倍（到 80GB)。模型大小的增速几乎比计算资源快两个数量级，这使得将最大的模型微调到下游任务对大多数人来说是不可行的，对所有人来说都是不切实际的。

因此，上下文学习（In-context learning）(Radford et al.，2019）成为了新常态，成为将下游任务训练数据传递给十亿规模语言模型的标准方式。然而，Transformer 有限的上下文大小人为地将训练集大小限制在仅几个例子，通常少于 100 个。这个限制，加上即使在训练数据上也缺乏上下文学习性能保证，提出了一个挑战。此外，扩大上下文大小会导致推理成本呈二次方增加。尽管语言模型在少样本（few-shot）场景下表现出色（Brown et al.，2020)，但 "增加数据量" 仍然是提高任何给定任务性能的最可靠方法。因此，作为研究人员和工程师的社区，我们需要高效的方法来训练下游任务数据。

参数高效微调（PEFT）旨在通过仅训练一小部分参数来解决这个问题，这些参数可能是现有模型参数的子集或一组新增的参数。这些方法在参数效率、内存效率、训练速度、模型的最终质量以及额外的推理成本（如果有的话）方面有所不同。在过去几年中，已发表了 100 多篇 PEFT 论文，有几项研究（Ding et al.，2022）对最流行的方法进行了很好的概述，如适配器（Adapters）(Houlsby et al.，2019)、位适应（BitFit）(Ben-Zaken et al.，2021)、低秩适应（LoRa）(Hu et al.，2021)、压缩器（Compacter）(Karimi Mahabadi et al.，2021）和软提示（Soft Prompts）(Liu et al.，2021; Li and Liang，2021)。最近，Pfeiffer et al.（2023）提出了一项关于模块化深度学习的调查，从模块化和多任务推理的角度概述了类似的方法。

本调查系统地概述、比较和分类了 30 种参数高效微调方法，深入讨论了 20 种方法，涵盖了 2019 年 2 月至 2023 年 2 月间发表的 40 多篇论文。我们强调了 PEFT 中当前未解决的挑战，包括有限的理论理解、PEFT 和完全微调性能之间的差距以及结果报告问题。最后，我们提出了几个改进方向，如开发标准化的 PEFT 基准、研究具有更优参数与秩比的新型重参数化技术、对超参数和可解释性进行深入研究，以及从设备端（边缘）机器学习研究中汲取灵感。

2 Background: Transformer

Many of the parameter-efficient fine-tuning techniques discussed in this survey can be applied to all neural networks, but some are specifically designed to take advantage of the Transformer architecture (Vaswani et al., 2017). Given that Transformers are the largest neural networks ever trained, these methods are particularly valuable. Thus, we present a brief overview of the Transformer to provide context for these techniques.

The core building block of the Transformer architecture consists of multi-head attention (MHA) followed by a fully-connected network (FFN), as illustrated in Figure 1. Both attention and fully-connected layers incorporate residual connections (He et al., 2016) and Layer Normalization (Ba et al., 2016) to improve trainability.

The heart of the Transformer is attention operation. Following the NamedTensor notation (Chiang et al., 2021), it can be described as

Att : R^key × R^seq×key × R^seq×val → R^val
Att(Q, K, V) = softmax_seq(Q_key K / sqrt(|key|))_seq V
Q(x) = x · W_Q + b_k,
K(x) = x · W_K + b_q,
V(x) = x · W_V + b_v,
W_Q, W_K ∈ R^input×key, W_V ∈ R^input×val
b_Q, b_K ∈ R^key, b_V ∈ R^val

A number of methods act specifically on the matrices W_K, W_Q, W_V, as they provide the main mechanism to pass information from one token to another and control what information (value) is being passed.

Although specific implementations of the Transformer may vary, such as incorporating a cross-attention layer in seq2seq networks or using LayerNorm before sublayers (Pre-LN), most parameter-efficient fine-tuning methods for Transformers only rely on the basic MHA + FFN structure and can be readily adapted to architecture variations.

3 Taxonomy of PEFT: a birds-eye view

PEFT methods can be classified in multiple ways. They may be differentiated by their underlying approach or conceptual framework: does the method introduce new parameters to the model, or does it fine-tune a small subset of existing parameters? Alternatively, they may be categorized according to their primary objective: does the method aim to minimize memory footprint or only storage efficiency? In this section, we begin by presenting a taxonomy based on the former. We depict this taxonomy and 30 PEFT methods in Figure 2. Sections 3.1-3.4 give a brief taxonomy overview. Then, based on our taxonomy classification, we describe 20 PEFT methods in detail, accompanied by the pseudocode in Sections 6 - 11.

3.1 Additive methods

The main idea behind additive methods is augmenting the existing pre-trained model with extra parameters or layers and training only the newly added parameters. As of now, this is the largest and widely explored category of PEFT methods. Within this category, two large subcategories have emerged: Adapter-like methods and soft prompts.

Adapters Adapters (Houlsby et al., 2019) are a type of additive parameter-efficient fine-tuning method that involves introducing small fully-connected networks after Transformer sub-layers. The idea has been widely adopted (Pfeiffer et al., 2020b), and multiple variations of Adapters have been proposed. These variations include modifying the placement of adapters (He et al., 2022a; Zhu et al., 2021), pruning (He et al., 2022b), and using reparametrization to reduce the number of trainable parameters (Karimi Mahabadi et al., 2021; Edalati et al., 2022).

Soft Prompts Language model prompting (Radford et al., 2019) aims to control the behavior of a language model by modifying the input text, which typically consists of a task description accompanied by a few in-context examples. However, these methods are difficult to optimize and are inherently limited in the number of training examples by the maximum model input length. To address these drawbacks, the concept of "soft" prompts was introduced (Liu et al., 2021; Lester et al., 2021; Li and Liang, 2021), where a part of the model's input embeddings is fine-tuned via gradient descent. This pivots the problem of finding prompts in a discrete space to a continuous optimization problem. Soft prompts can be trained for the input layer only (Liu et al., 2021; Lester et al., 2021) or for all layers (Li and Liang, 2021). Recent advancements explore how soft prompts could be pre-trained or prompts for different tasks utilized to reduce the computation required for fine-tuning a soft prompt for a new task (Vu et al., 2021; Hambardzumyan et al., 2021; Su et al., 2021; Qin et al., 2021).

Other additive approaches Additive methods are a diverse category of parameter-efficient fine-tuning techniques that extends beyond adapters and soft prompts. For example, LeTS (Fu et al., 2021), LST (Sung et al., 2022), and (IA)^3 (Liu et al., 2022) introduce novel ways to add parameters that improve adapters or soft prompts in terms of memory, computation, or accuracy.

Why add parameters? Although these methods introduce additional parameters to the network, they achieve significant training time and memory efficiency improvements by reducing the size of the gradients and the optimizer states. Note that in the case of Adam (Kingma and Ba, 2015), for every byte of trainable parameter, one extra byte is needed for its gradient, and two more bytes are needed to store the optimizer state: the first and second moments of the gradient. In practice, depending on the setup, training a model requires 12-20 times more GPU memory than the model weights. By saving memory on optimizer states, gradients, and allowing frozen model parameters to be quantized (Dettmers et al., 2022), additive PEFT methods enable the fine-tuning of much larger networks or the use of larger micro-batch sizes. Which improves training throughput on GPUs. Moreover, optimizing fewer parameters in distributed setups drastically reduces communication volume.

3.2 Selective methods

Arguably the earliest example of selective PEFT is fine-tuning only a few top layers of a network (Donahue et al., 2014). Modern approaches are usually based on the type of the layer (Gheini et al., 2021) or layer type-based lection, or even individual parameter selection.

An extreme version of selective methods is sparse update methods which can completely ignore the structure of the model, and select parameters individually (Sung et al., 2021; Ansell et al., 2022; Guo et al., 2020). However, sparse parameter updates present multiple engineering and efficiency challenges, some of which have been tackled in recent research on parameter reconfiguration (Vucetic et al., 2022) (Section 9.3) and NxM sparsity (Holmes et al., 2021). Nevertheless, unrestricted unstructured sparsity is still impractical on contemporary hardware.

3.3 Reparametrization-based methods

Reparametrization-based parameter-efficient fine-tuning methods leverage low-rank representations to minimize the number of trainable parameters. The notion that neural networks have low-dimensional representations has been widely explored in both empirical and theoretical analysis of deep learning (Maddox et al., 2020; Li et al., 2018; Arora et al., 2018; Malladi et al., 2022).

Aghajanyan et al. (2020) have demonstrated that fine-tuning can be performed effectively in low-rank subspaces. Further, they showed that the size of the subspace that needs adaption is smaller for bigger models or the models pre-trained for longer. Their approach, referred to as Intrinsic SAID (Section 10.1), employs the Fastfood transform (Le et al., 2013) to reparametrize the update to neural network parameters.

However, perhaps the most well-known reparametrization-based method is Low-Rank Adaptation or LoRa (Hu et al., 2021), which employs a simple low-rank matrix decomposition to parametrize the weight update δW = W_down W_up. This approach is straightforward to implement and has been evaluated on models with up to 175 billion parameters. We provide a detailed discussion of this method in Section 10.2. More recent works (Karimi Mahabadi et al., 2021; Edalati et al., 2022) have also explored the use of Kronecker product reparametrization (δW = A ⊗ B), which yields a more favorable tradeoff between rank and parameter count.

3.4 Hybrid methods

A number of methods have emerged that combine ideas from multiple categories of PEFT (He et al., 2022a,b; Mao et al., 2021; Karimi Mahabadi et al., 2021). For instance, MAM Adapter (Section 11.2) incorporates both Adapters and Prompt tuning. UniPELT (Section 11.3) adds LoRa to the mixture. Compacter and KronA_B^res reparametrize the adapters to reduce their parameter count (Sections 11.4 and 10.3). Finally, S4 (Section 11.5) is a result of an automated algorithm search that combines all PEFT classes to maximize accuracy at 0.5% of extra parameter count.

4 Comparing PEFT methods

Parameter efficiency encompasses multiple aspects, including storage, memory, computation, and performance. However, achieving parameter efficiency alone does not necessarily lead to reduced RAM usage. For example, DiffPruning (Section 9.2) entails training a binary mask with the same number of parameters as the model. Consequently, this method can be only considered storage-efficient, while still incurring considerable RAM and time costs during fine-tuning.

To compare PEFT methods, we keep five dimensions of comparison in mind: storage efficiency, memory efficiency, computation efficiency, accuracy, and inference overhead. We observe that while they aren't completely independent from one another, improvements along one of the axes do not necessarily translate into improvements along others (Table 1).

5 Overview of PEFT Approaches

In the next sections, we dive into the details of several parameter-efficient fine-tuning approaches. We will describe the distinctions and tradeoffs between them in terms of the axes outlined in Section 4. We bold a one-sentence summary of each method to simplify skimming through them.

In the method description, we also indicate whether it has been applied to models with fewer than 1 billion, fewer than 20 billion, or more than 20 billion parameters. The model size summary can be found in Table 2. We stick to the parameter counts indication where possible because the words "small" and "large" change their meaning too quickly. Finally, we provide a brief pseudo-PyTorch implementation of the most important part of the algorithm where it's feasible.

6 Additive methods: Adapters

We start our dive into PEFT methods with one of the largest sub-families of methods that are built on the idea of adding fully-connected networks between model layers, i.e., adapters.

6.1 Adapters

The idea of Adapters was initially developed for multi-domain image classification (Rebuffi et al., 2017, 2018) and consisted in adding domain-specific layers between neural network modules. Houlsby et al. (2019) adapt this idea to NLP. They propose to add fully-connected networks after attention and FFN layers in Transformer. Unlike the transformer FFN block, Adapters usually have a smaller hidden dimension than the input. Adapters have demonstrated impressive parameter efficiency at the time, showing that it is possible to achieve performance competitive to full fine-tuning by tuning less than 4% of the total model parameters.

A schematic adapter implementation:

def transformer_block_with_adapter(x):
    residual = x
    x = SelfAttention(x)
    x = FFN(x) # adapter
    x = LN(x + residual)
    residual = x
    x = FFN(x) # transformer FFN
    x = FFN(x) # adapter
    x = LN(x + residual)
    return x

Pfeiffer et al. (2020a) found that inserting the adapter only after the self-attention layer (after normalization) achieves similar performance as using two adapters per transformer block.

6.2 AdaMix

AdaMix (Wang et al., 2022) improves the performance of adapters by utilizing multiple adapters in a mixture-of-experts (MoE) fashion (Shazeer et al., 2017).

Meaning, that each adapter layer is a set of layers (experts), and for each forward pass only a small set of experts is activated. In contrast to a regular MoE, which selects and weights multiple experts using a routing network AdaMix randomly selects a single expert for each forward pass. This minimizes computational costs and, according to Wang et al. (2022), doesn't degrade performance. Another difference from a regular MoE layer is that up and down projections of the adapter are selected independently. After training, the adapter weights are averaged across the experts which makes inference more memory-efficient. To stabilize training, the authors propose consistency regularization which minimizes symmetrized KL between two models' forwards with different sets of experts selected.

Although AdaMix achieves better performance than regular adapters with the same inference cost, it can use more memory during training. Wang et al. (2022) show that AdaMix can use much smaller adapter hidden states, which amortizes trainable parameter overhead over the number of experts (∼4-8). However, the consistency regularization technique increases computational requirements and memory consumption, as it needs to keep two versions of the hidden states and gradients over two model forward passes with different experts.

def transformer_block_with_adamix(x):
    residual = x
    x = SelfAttention(x)
    x = LN(x + residual)
    residual = x
    x = FFN(x)
    # adamix starts here
    x = random_choice(experts_up)(x)
    x = nonlinearity(x)
    x = random_choice(experts_down)(x)
    x = LN(x + residual)
    return x

def consistency_regularization(x):
    logits1 = transformer_adamix(x)
    # second pass uses different experts
    logits2 = transformer_adamix(x)
    r = symmetrized_KL(logits1, logits2)
    return r

7 Additive Methods: Soft Prompts

Prompting language models has demonstrated remarkable performance in zero- and few-shot scenarios (Brown et al., 2020; Schick and Schütze, 2021). However, optimizing discrete natural language prompts or using in-context learning is impractical when there are many training examples. To overcome this challenge, the concept of "soft" or "continuous" prompts was proposed (Li and Liang, 2021; Lester et al., 2021; Liu et al., 2021) that converts the discrete optimization problem of finding the best "hard" prompt to a continuous one.

7.1 Prompt Tuning

Prompt tuning (Lester et al., 2021) proposes to prepend the model input embeddings with a trainable tensor P ∈ R^l×h. This tensor is commonly referred to as "soft prompt" and it is optimized directly through gradient descent.

def soft_prompted_model(input_ids):
    x = Embed(input_ids)
    x = concat([soft_prompt, x], dim=seq)
    return model(x)

Ablation studies by Su et al. (2021) over prompt length from 1 to 150 tokens and model size from 10M to 11B parameters reveal that prompt tuning is more parameter efficient the larger the model. For instance, prompt tuning of T5-11B achieves the same SuperGLUE (Wang et al., 2019) performance with either 5 or 150 soft prompt length. Furthermore, efficiency grows faster than the model size: T5-large performance saturates at prompt length 20 or 20K trainable parameters (0.002%), and T5-XL performance saturates prompt length 5, also 20K trainable parameters (0.0002%). However, prompt tuning only becomes comparable with full fine-tuning at the 10B model scale. Also, increasing the length of the input by 20-100 tokens can significantly increase computation, given the quadratic complexity of the transformer. Overall, soft prompts are incredibly parameter-efficient at the cost of inference overhead and more applicable to larger models.

7.2 Prefix-Tuning

Li and Liang (2021) independently develop the idea of soft prompts with a distinctive flavor: instead of adding a soft prompt to the model input, trainable parameters are prepended to the hidden states of all layers. The same prefix P_θ ∈ R^l×h is prepended to all of the hidden states. They observe that directly optimizing the soft prompt leads to instabilities during training. Instead, soft prompts are parametrized through a feed-forward network P_θ = FFN(P̂_θ). During training, P̂_θ and the parameters of the FFN are optimized. After, only P_θ is needed for inference, and the FFN can be discarded.

Pseudocode for a single layer:

def transformer_block_for_prefix_tuning(x):
    soft_prompt = FFN(soft_prompt)
    x = concat([soft_prompt, x], dim=seq)
    return transformer_block(x)

Note that the approach is very similar to Prompt-tuning (Section 7.1), but the soft prompts are added in each layer.

In their experiments, Li and Liang (2021) apply BART (Lewis et al., 2019) model (<1B) to different generation tasks and show a performance close to the full fine-tuning by training only 0.1% parameters. Soft prompt lengths used in the study vary from 10 to 200 tokens.

7.3 Intrinsic Prompt Tuning (IPT)

Prompt tuning methods, despite being parameter efficient, present practical problems such as slow convergence and a need to store all of the task-specific parameters. A few studies (Su et al., 2021; Vu et al., 2021) proposed to pre-train soft prompts to improve performance and convergence speed. However, these methods do not provide solutions to reduce the number of parameters per task.

Qin et al. (2021) hypothesize that the h-dimensional space used to define soft prompt parameters contains an "intrinsic task subspace" that can differentiate between various tasks.

IPT method works in three steps. First, given a set of training tasks, their soft prompts are learned in a regular way (Section 7.1). Then, these prompts are used to train an autoencoder that compresses their dimensionality. After this, the encoder part is discarded, and only the input to the autoencoder decoder is trained on new tasks. In summary, IPT uses an autoencoder to (de)compress the soft prompt.

def autoencoder(soft_prompt):
    soft_prompt = soft_prompt.flatten()
    P = FFN_A(soft_prompt) # encoder
    P = FFN_B(P) # decoder
    P = P.reshape(prompt_len, hidden)
    return P

def soft_prompted_model(x):
    P = FFN_B(intrinsic_subspace_prompt)
    P = P.reshape(prompt_len, hidden)
    x = concat([P, x], dim=seq)
    return model(x)

Even though the IPT framework reduces the number of parameters for the unseen tasks, this reduction comes at the price of training the autoencoder. The authors conduct experiments with the BART-base model and a prompt length of 100. The resulting autoencoder, which is implemented as a fully-connected network that accepts a one-dimensional tensor of size 768 · 100 reaches approximately 78 million parameters. I.e., over 56% of total parameters in the BART-base model. Hence, significantly more efficient ways of prompt autoencoding are required to make IPT practically applicable.

8 Additive Methods: Other Approaches

Several of the additive PEFT methods do not follow the idea of either adapters or soft prompts and propose to augment a pre-trained network in an original way.

8.1 Ladder-Side Tuning (LST)

Ladder-Side Tuning (Sung et al., 2022) trains a small transformer network on the side of the pre-trained network. This side network combines the hidden states of the pre-trained backbone network with its own hidden states.

This way, the side network only uses the pre-trained model as a feature extractor, and backpropagation must only be computed through the side network saving on both memory and compute during training. The authors also use multiple tricks to improve the performance and parameter efficiency of LST. Namely, initializing the side network from the pre-trained model parameters using structural pruning and using twice (or 4x) fewer layers in the side network than in the backbone network.

The pseudocode:

def ladder_side_layer(x, h_pt):
    h_pt = h_pt @ W_down # to x.shape
    gate = sigmoid(alpha)
    x = gate * x + (1 - gate) * h_pt
    return transformer_block(x)

def ladder_side_network(x):
    with no_grad():
        H_pt = pretrained_network(
            x, return_all_hiddens=True
        )
    for i in range(layers):
        layer = ladder_side_layers[i]
        x = layer(x, H_pt[i])
    return x

Where h_pt is the output of the corresponding layer of the pre-trained network, and alpha is an input-independent trainable scalar gate.

LST demonstrated a three-fold RAM reduction in fine-tuning T5-Base compared to full fine-tuning and a two-fold RAM usage reduction compared to LoRa (Section 10.2) with a small degradation in accuracy and outperforms these methods when controlling for RAM usage.

8.2 (IA)^3

Liu et al. (2022) propose a new parameter-efficient method to multi-task fine-tune T-few. (IA)^3 learns new parameters l_v, l_k, l_ff which rescale key, value, and hidden FFN activations. Specifically,

def transformer_block_with_ia3(x):
    residual = x
    x = ia3_self_attention(x)
    x = LN(x + residual)
    residual = x
    x = x @ W_1 # FFN in
    x = l_ff * gelu(x) # (IA)3 scaling
    x = x @ W_2 # FFN out
    x = LN(x + residual)
    return x

def ia3_self_attention(x):
    k, q, v = x @ W_k, x @ W_q, x @ W_v
    k = l_k * k
    v = l_v * v
    return softmax(q @ k.T) @ V

Training only these three vectors l_v, l_k, l_ff for each transformer block leads to high parameter efficiency. For T0-3B, it only updates about 0.02% of model parameters and outperforms other methods, including Compacter (Section 11.4) with similar parameter count and LoRa (Section 10.2) with 16 times more trainable parameters. Unlike adapters-tuned models, (IA)^3-tuned models exhibit minimal overhead. Vectors l_v and l_k can be integrated into the corresponding linear layers, and the only overhead comes from l_ff.

9 Selective Methods

Selective methods fine-tune a subset of the existing parameters of the model. It could be a layer depth-based selection, layer type-based lection, or even individual parameter selection.

9.1 BitFit

Ben-Zaken et al. (2021) propose to only fine-tune the biases of the network. That is, for every linear or convolutional layer, the weight matrix W is left as is, and only the bias vector b is optimized.

params = (p for n, p
          in model.named_parameters()
          if "bias" in n)
optimizer = Optimizer(params)

BitFit only updates about 0.05% of the model parameters. The original paper demonstrated that the method achieves similar performance to full fine-tuning or better performance in low and medium-data scenarios in BERT models (<1B parameters). Further research evaluated the method on larger networks such as T0-3B (Sanh et al., 2022; Liu et al., 2022) or GPT-3 (Hu et al., 2021). At this scale, BitFit significantly underperforms full fine-tuning, and other PEFT approaches.

9.2 DiffPruning

DiffPruning (Guo et al., 2020) aims to achieve parameter efficiency by learning a sparse update of a neural network's weights. The method introduces a learnable binary mask on the weights, denoted by δ = z ◦ ∆W, where ◦ represents the Hadamard product. This parameter mask is learned during model fine-tuning as part of the regularization objective, which is a differentiable approximation to the L_0 norm of the update vector δ.

DiffPruning has achieved comparable performance to full fine-tuning while modifying only 0.5% of the model parameters in smaller-scale (<1B) scenarios. This makes it a useful method for multi-task deployment for edge (mobile) scenarios where storage is limited. However, this method requires more memory than traditional fine-tuning, as it involves optimizing all parameters during training in addition to the learnable binary mask.

9.3 Freeze and Reconfigure (FAR)

FAR (Vucetic et al., 2022) selects columns of parameter matrices to prune and reconfigures linear layers into trainable and frozen. The method operates in two stages. In the first stage, the most important rows of parameter matrices are identified for updating. This process is similar to structured pruning and can use any pruning method. In their paper, the authors fine-tune the model on a percentage of the data and select the top-r rows based on the L_1 distance between the fine-tuned and original models.

In the second stage, the network is reconfigured by splitting each parameter W ∈ R^in×h into a trainable component W_t ∈ R^in×h' and a frozen component W_f ∈ R^in×(h-h'), where h' is the desired number of trainable parameters. The matrix multiplications with W_t and W_f are computed independently, and the results are concatenated. A similar operation is performed on biases.

Pseudocode implementation is rather simple

def far_layer(x):
    h1 = x @ W_t
    h2 = x @ W_f
    return concat([h1, h2], dim=-1)

While this approach creates additional compute overhead during training, it provides great flexibility in terms of parameter selection on modern hardware using standard frameworks like PyTorch. After training, the parameters can be reconfigured back removing any inference overhead.

The original paper focused on edge scenarios and used DistilBERT (66M) for their experiments. FAR was only applied to feed-forward layers, as these make up the majority of the DistilBERT parameters. The authors showed that FAR achieved similar performance to fine-tuning on five GLUE tasks and SQuAD 2.0 (Rajpurkar et al., 2018) while updating 6% of the parameters.

9.4 FishMask

FishMask (Sung et al., 2021) is a sparse fine-tuning method that selects top-p parameters of the model based on their Fisher information. Fisher information is estimated in a common way through a diagonal approximation

F̂_θ = 1/N Σ_{i=1}^N E_{y~p_θ(y|x_i)} [(∇_θ log p_θ(y|x_i))^2]

Thus, the method requires computing gradients for all parameters on (several batches of) the data. However, after the highest-Fisher parameters are selected, only they need to be optimized.

Pseudocode to compute the masks:

sparsity = 0.99
N = len(data)
for x, y in data:
    loss = loss_fn(model(x), y)
    loss.backward()
    for n, p in model.named_params():
        fisher[n] += p.grad ** 2 / N
threshold = percentile(fisher, sparsity)
masks = {n: f > threshold
         for n, f in fisher.items()}

The method generally performs on-par with adapters but sub-par to LoRa and (IA)^3 (Sections 10.2 and 8.2). It has been evaluated on BERT (<1B) and T0-3B models. However, FishMask is computationally intensive and inefficient on contemporary deep learning hardware due to the lack of support for sparse operations.

10 Reparametrization-based methods

These methods use the idea of reparametrizing the weights of the network using a low-rank transformation. This decreases the trainable parameter count while still allowing the method to work with high-dimensional matrices, such as the pre-trained parameters of the networks.

10.1 Intrinsic SAID

In their work, Aghajanyan et al. (2020) investigate the intrinsic dimensionality of fine-tuning and demonstrate that this process can be performed in a low-rank subspace.

Specifically, they use the Fastfood transform to reparametrize the update to the model weights. Fastfood is a compute-efficient dimensionality expansion transform F : R^d → R^D that can be done in O(D log d) time and O(D) memory.

Their results indicate that larger models require changes in a lower-rank subspace compared to smaller models to achieve the same fine-tuning performance. This observation motivates both scaling large models and parameter-efficient fine-tuning. It is important to note that, unlike methods that select a particular subset of parameters for fine-tuning, Intrinsic SAID updates all model parameters in a low-rank manner, i.e., θ = θ_0 + F(θ_d), where θ_0 ∈ R^D denotes the pre-trained model parameters and θ_d ∈ R^d denotes the parameters to be optimized. Therefore, while the number of optimizable parameters is low, the O(D) memory complexity of Fastfood and the update to all of the model's parameters make Intrinsic SAID impractical for fine-tuning large networks. For more details on Fastfood, we refer the reader to the original paper by Le et al. (2013).

10.2 LoRa

LoRa (Hu et al., 2021) takes inspiration from IntrinsicSAID and proposes a simpler way to perform low-rank fine-tuning. Parameter update for a weight matrix in LoRa is decomposed into a product of two low-rank matricies

δW = W_A W_B
W_A ∈ R^in×r, W_B ∈ R^r×out

All pre-trained model parameters are kept frozen, and only W_A and W_B matrices are trainable. The scaling factor is constant and typically equals 1/r. After training, they can be integrated into the original W by just adding the matrix W_A W_B to the original matrix W.

Pseudocode is very simple:

def lora_linear(x):
    h = x @ W # regular linear
    h += x @ W_A @ W_B # low-rank update
    return scale * h

In Transformers, LoRa is typically used for W_K and W_V projection matrices in multi-head attention modules. The method outperforms BitFit and Adapters and has been evaluated on the models up to 175B parameters.

10.3 KronA

KronA (Edalati et al., 2022) replaces matrix factorization δW = W_A W_B in LoRa (Section 10.2) with a matrix factorization through a Kronecker product δW = W_A ⊗ W_B. This yields a better rank per parameters tradeoff because the Kronecker product keeps the rank of the original matrices being multiplied. Or, in other words, rank(A ⊗ B) = rank A · rank B. Additionally, Edalati et al. (2022) propose to use efficient Kronecker product-vector product operation x(A⊗B) which avoids representing δW explicitly and leads to significant speedups

Krona pseudocode:

def krona_linear(x):
    x = x @ W # regular linear
    x += kronecker_vector_prod(x, W_A, W_B)
    return scale * x

# same as x @ kronecker_product(A, B)
def kronecker_vector_prod(x, A, B):
    x = x.reshape(A.shape[1], B.shape[1])
    x = A.T @ x @ B
    return x.reshape(-1)

KronA_B^res is another method presented in Edalati et al. (2022). It is a parallel adapter with Kronecker product-parametrization of the weights and a residual connection.

On GLUE, KronA methods perform on-par or better than adapters (Section 6.1), LoRa (Section 10.2), and Compacter (Section 11.4) at the same trainable parameter count 0.07% while being significantly faster than adapters or Compacter at inference time. The method was evaluated only on small (<1B) models.

Background: What is a Kronecker product?
Kronecker product is a tensor operation defined as

A ⊗ B : R^n×m × R^k×l → R^nk×ml
A ⊗ B = [a_1,1B ... a_1,nB
          ...    ...   ...
          a_m,1B ... a_m,nB]

It can be easily implemented in PyTorch using the command torch.einsum

def batched_kronecker_product(a, b):
    bs, i, j = a.shape
    bs, k, m = b.shape
    res = einsum("bij,bkm->bikjm", a, b)
    return res.view(bs, i * k, j * m)

11 Hybrid Approaches

Hybrid methods for parameter-efficient fine-tuning combine different techniques and strategies to achieve better performance while reducing the computational costs associated with fine-tuning large neural networks. These methods can be viewed as a synergistic blend of multiple approaches. The resulting hybrid methods can leverage the strengths of each individual technique, while mitigating their weaknesses, leading to improved performance and efficiency.

11.1 SparseAdapter

He et al. (2022b) propose Large-Sparse strategy to train adapter layers. In this strategy, they use a large hidden dimension for the added module and prune around 40% of the values at initialization. Large-Sparse consistently outperforms its non-sparse counterpart with the same trainable parameter count. However, training and inference costs can be higher depending on hardware support for sparse tensors and operations. It is also worth noting that computing the pruning mask for this method may require obtaining gradients for all newly added parameters.

11.2 MAM Adapters

In their study, He et al. (2022a) conducted a thorough investigation of adapter placement and soft prompts. They concluded that scaled parallel adapters outperform sequentially-placed adapters and that placing an adapter in parallel to FFN outperforms multi-head attention-parallel adapters. They also notice that soft prompts can efficiently modify attentions by only changing 0.1% of the parameters and propose to "mix-and-match" (MAM) these ideas. Their final model, MAM Adapter is a combination of scaled parallel adapter for FFN layer and soft prompt.

def transformer_block_mam(x):
    x = concat([x, soft_prompt], dim=seq)
    residual = x
    x = SelfAttention(x)
    x = LN(x + residual)
    x_a = FFN(x) # parallel adapter
    x_a = scale * x_a
    x = LN(x + x_adapter)
    return x

MAM method outperforms BitFit and PromptTuning by a large margin and consistently outperforms LoRa (Section 10.2), Adapters (Section 6.1), and Prefix Tuning (Section 7.2) with 200 soft prompt length at 7% extra parameters. The experiments were concluded on <1B models.

It's worth noting that parallel adapters were independently studied by Zhu et al. (2021) in the domain of machine translation.

11.3 UniPELT

UniPELT (Mao et al., 2021) is a gated combination of LoRa, Prefix-tuning, and Adapters. More specifically, LoRa reparametrization is used for W_Q and W_V attention matrices, prefix-tuning is applied to keys and values of each layer, and adapters are added after the feed-forward layer of the transformer block. For each of the modules, gating is implemented as a linear layer projecting the module input into a dimension of size one, sigmoid activation, and averaging the resulting vector over the sequence length. Trainable parameters include LoRa matrices W_A, W_B, prompt tuning parameters P_q, P_k, adapter parameters, and gating function weights.

Next, we present a schematic implementation of UniPELT. We omit multiple attention heads for simplicity.

def transformer_block_with_unipelt(x):
    residual = x
    x = unipelt_self_attention(x)
    x = LN(x + residual)
    residual = x
    x = FFN(x)
    adapter_gate = gate(x)
    x = adapter_gate * FFN(x)
    x = LN(x + residual)
    return x

def unipelt_self_attention(x):
    k, q, v = x @ W_k, x @ W_q, x @ W_v
    # lora for queries and values
    lora_gate = gate(x)
    q += lora_gate * W_qA @ W_aB
    v += lora_gate * W_vA @ W_vB
    # prefix tuning
    pt_gate = gate(x)
    q_prefix = pt_gate * P_q
    k_prefix = pt_gate * P_k
    return softmax(q @ k.T) @ V

def gate(x):
    x = Linear(x)
    x = sigmoid(x)
    return mean(x, dim=seq)

UniPELT demonstrates significant improvements over individual LoRa, Adapters, and Prefix Tuning approaches in low-data scenarios with only 100 examples. In higher data scenarios, UniPELT performs on par or better than these approaches. Mao et al. (2021) reports 1.3% trainable model parameters using UniPELT on BERT (<1B parameters) models.

11.4 Compacter

Compacter (Karimi Mahabadi et al., 2021) utilizes Kronecker product, low-rank matrices, and parameter sharing across layers to produce adapter weights. Each parameter W in an adapter is equal to a sum of Kronecker products

Ŵ = Σ_{i=0}^n A_i ⊗ B_i
Ŵ ∈ R^k×d, A_i ∈ R^n×n, B_i ∈ R^(k/n)×(d/n).

A linear layer x Ŵ + b with this parametrization is called parametrized hypercomplex multiplication (PHM) layer (Zhang et al., 2021). Compacter takes this idea futher, parametrizing B_i similar to LoRa (Section 10.2) B_i = B_down_i B_up_i where all matricies are of rank at most r. Matrices A_i are shared across all adapter layers for further parameter efficiency. The corresponding layer is named Low-rank PHM or LPHM. Compacter layer pseudocode:

def compacter(x):
    x = LPHM(x) # Essentially an FFN
    x = gelu(x) # but
    x = LPHM(x) # LPHM replaces linear
    return x

def lphm_forward(x):
    B = B_d @ B_u
    W = batched_kronecker_product(A, B)
    W = sum(W, dim=0)
    return x @ W + b

Note that all A and B are 3D tensors with the first dimension equal to n, the number of Kronecker products in the PHM layer.

Compacter comes in two flavors: two adapters per transformer block or a single adapter after a feedforward layer (Compacter++). With only 0.05% additional parameters Compacter++ performs on par or better than adapters with 0.8% additional parameters. The model has been evaluated on T5 Base (<1B) and T0-3B.

11.5 S4

Chen et al. (2023) conduct an extensive exploration of various combinations of parameter-efficient fine-tuning techniques. Their search space includes dividing consecutive layers into four uneven groups, allocating varying amounts of trainable parameters to each layer, determining which groups to fine-tune, and deciding which PEFT methods to apply to each group.

Their proposed method, S4, divides layers into four groups (G_1,2,3,4) using a "spindle" pattern: more layers are allocated to the middle groups and fewer to the top and bottom groups. All groups are trainable, with trainable parameters uniformly allocated across the layers (not groups). Different combinations of PEFT methods are applied to different groups. Specifically,

G_1: A, L   G_3: A, P, B
G_2: A, P   G_4: P, B, L 

where A stands for Adapters (Section 6.1), P for Prefix-Tuning (Section 7.2), B for BitFit (Section 9.1), and L for LoRa (Section 10.2).

The search experiments were conducted on T5-base and the GLUE dataset at 0.5% trainable parameters. The S4 method was then applied to T5-3B, RoBERTa, and XL-Net, consistently outperforming individual BitFit, Prefix Tuning, LoRa, and Adapters across different architectures, model sizes, and tasks.

12 Reporting and comparison issues

Survey papers tend to discuss reporting issues, and unfortunately, this one is not an exception. We identified several challenges and inconsistencies that warrant discussion. These challenges make it difficult to draw direct comparisons between methods and evaluate their true performance.

Inconsistent Parameter Counts One of the primary challenges stems from the difference in the way researchers report parameter counts. These inconsistencies are not a result of dishonesty but arise from the inherent complexity of the problem. Generally, parameter counts can be categorized into three types: the number of trainable parameters, the number of changed parameters between the original and fine-tuned models, and the rank of the difference between the original and fine-tuned models.

These distinctions can have significant implications. For example, IntrinsicSAID (Section 10.1) learns a low-rank (∼100-1000) transformation of model parameters. However, it changes all of the model's parameters. DiffPruning (Section 9.2) learns an update of 0.5% parameters, but it actually trains 200% parameters: fine-tuning the model and learning the binary mask. For reparameterization-based methods (Sections 10.2, 10.3, 11.4), memory requirements may vary depending on the implementation design choices.

Of the three types, the number of trainable parameters is the most reliable predictor of memory efficiency. However, it is still imperfect. For instance, Ladder-side Tuning (Section 8.1) uses a separate side-network with more parameters than LoRa or BitFit, but it requires less RAM, since backpropagation is not computed through the main network.

Model Size Another challenge arises from the variation in model sizes used in the evaluation of PEFT methods. Several studies (Aghajanyan et al., 2020; Hu et al., 2021) have demonstrated that larger models require fewer parameters to be updated during fine-tuning, both in terms of percentage and when the model is large enough, sometimes even in absolute terms (Li and Liang, 2021). Thus, model size must be considered when comparing PEFT methods, not just the ratio of trainable parameters.

Lack of Standard Benchmarks and Metrics The absence of standard benchmarks and metrics further complicates comparisons. New methods are often evaluated on different model/dataset combinations, making it challenging to draw meaningful conclusions.

We would like to highlight the papers that report a variety of metrics on standard datasets simplifying comparison to other methods. For example, KronA (Edalati et al., 2022) evaluated T5-base on the GLUE benchmark and reported accuracy, training time, and inference time while maintaining the same number of trainable parameters. UniPELT (Mao et al., 2021) assessed BERT on the GLUE benchmark and reported accuracy, training time, and inference latency, although it used different parameter counts for various methods. LST (Sung et al., 2022) evaluated different T5 sizes on the GLUE benchmark, reporting metrics such as accuracy, training time, the number of updated parameters, and memory usage. MAM (He et al., 2022a) applied multiple models to the XSUM benchmark and reported accuracy across a range of trainable parameters, although memory comparisons were not provided.

However, even these papers lack full comparability due to differences in their evaluation settings, such as varying parameter counts or the absence of certain metrics like memory comparisons. These inconsistencies highlight the need for a standardized benchmark and unified metrics to facilitate more accurate comparisons and evaluations of PEFT methods.

Issues with Published Implementations Another issue encountered is the state of published implementations. Many codebases are simply copies of the Transformers library (Wolf et al., 2020) or other repositories with only minor modifications. These copies often do not use git forks, making it difficult to identify the differences unless they are highlighted in the README file.

Furthermore, even when differences are easy to find, the code is frequently not reusable . Users are often required to install a modified version of the Transformers library, which conflicts with the most recent version and lacks documentation or any examples of how to reuse the method outside of the existing codebase.

Despite these challenges, there are some methods with reusable implementations worth highlighting, such as LoRa and Compacter. These implementations stand out for their user-friendliness and adaptability, providing a solid foundation for further research and development.

13 Best Practices

To address different issues identified in the parameter-efficient fine-tuning literature, we put forward the following best practices for future research:

Explicit reporting of parameter count type: We encourage authors to clearly specify the parameter count being reported in their papers or, ideally, report all three types of parameter count: trainable, changed, and rank. This will improve understanding and allow for more accurate comparisons between methods.

Evaluate with different model sizes: It is important to assess their methods using different model sizes, as this can provide a more comprehensive understanding of each method's strengths and limitations. This is particularly important considering that even recent papers often focus solely on BERT.

Comparisons to similar methods: In addition to comparing their methods with popular approaches (e.g., LoRa, BitFit, Adapters) we should also analyze their methods alongside other techniques that share conceptual and architectural resemblances. In our review, we often came across methods that were based on very similar ideas and designs but were never directly compared. Undertaking such comparisons will offer a more comprehensive understanding of a method's performance and its relative strengths in relation to existing techniques.

Standardized PEFT benchmarks and competitions: We propose the development of standardized PEFT benchmarks and competitions, which would require participants to compete under the same conditions and facilitate direct comparisons of results. These benchmarks should provide standardized data and models at different scales to evaluate training efficiency.

To assess training time and memory efficiency, competitions can offer a centralized server or specify a comprehensive server configuration that outlines the CPU type, amount of memory, and GPU type and quantity. Ideally, this could take the form of an instance template to one of the major cloud providers. GPU memory consumption should be evaluated in a standardized way.

Emphasize code clarity and minimal implementations: As a community, we need to prioritize code that is easy to understand and features simple, reusable implementations. In some cases, such implementations provide additional insight to the paper and could be written in a concise manner. This proposal is in the interest of individual researchers as well, as easy-to-reuse methods may become more popular and, consequently, more cited.

14 Discussion

The growing accessibility of large language models (Zhang et al., 2022; Zeng et al., 2022; Khrushchev et al., 2022; Touvron et al., 2023) and the democratization of their inference through low-bit quantization (Dettmers et al., 2022; Dettmers and Zettlemoyer, 2022) has enabled the research community to study, experiment, and tackle new tasks with relatively modest compute budgets. Parameter-efficient fine-tuning is the next step that will allow us not just to inference, but to modify these models.

Among the developed methods, some have demonstrated their practicality at scale (Table 2), such as Adapters (Section 6.1), Prompt Tuning (Section 7.1), LoRa (Section 10.2), and (IA)^3 (Section 8.2). However, in practice, matching the performance of full fine-tuning remains a challenge. One of the reasons is high sensitivity to hyperparameters, with optimal hyperparameters often significantly deviating from those used in full fine-tuning due to the varying number of trainable parameters. For instance, the optimal learning rate for parameter-efficient fine-tuning is generally much higher than that for full fine-tuning. The research community should promote in-depth investigations into the impact of hyperparameters on these methods and finding reasonable defaults, as parameter-efficient fine-tuning or large models can be noticeably costly at 20-100B scale. Additionally, efforts should be directed towards developing methods that minimize hyperparameter sensitivity, such as pre-training new parameters (Vu et al., 2021; Su et al., 2021).

Examining the taxonomy of methods and the progress made thus far, it is evident that low-rank reparameterization has been remarkably successful in enhancing parameter efficiency. LoRa-style (Section 10.2) and Kronecker-product (Sections 11.4 and 10.3) reparameterizations both decrease the number of trainable parameters while requiring minimal extra computation. A possible future direction of finding new PEFT models is exploring different reparametrization techniques with favorable trainable parameter count vs. rank ratio.

Another possible direction of improvement is utilizing what we know about how transformer models process texts (Rogers et al., 2020). Most of the PEFT methods work uniformly for the model, while we know that models process input differently at different layers. Utilizing this knowledge or building systems that have an adaptive number of parameters per layer could further improve parameter efficiency and accuracy.

In many respects, our current situation resembles the challenges from edge machine learning: we consistently face constraints in memory, computation, and even energy consumption. Techniques like quantization and pruning (Gupta et al., 2015; LeCun et al., 1989) widely used in edge machine learning, now benefit large language models. As we move forward, it is not only plausible but also likely that more ideas could be exchanged between these two areas. Cross-disciplinary collaboration could further exchange ideas, accelerating innovation and progress in parameter-efficient fine-tuning.

A Acknowledgements

We would like to thank Vladimir Kluenkov and Victoria Maltseva for their help with Figure 2.

