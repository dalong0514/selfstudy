## 2024004LoRA-Low-Rank-Adaption-of-Lanrge-Language-Models

### Abstract

An important paradigm of natural language processing consists of large-scale pretraining on general domain data and adaptation to particular tasks or domains. As we pre-train larger models, full ﬁne-tuning, which retrains all model parameters, becomes less feasible. Using GPT-3 175B as an example – deploying independent instances of ﬁne-tuned models, each with 175B parameters, is prohibitively expensive. We propose Low-Rank Adaptation, or LoRA, which freezes the pretrained model weights and injects trainable rank decomposition matrices into each layer of the Transformer architecture, greatly reducing the number of trainable parameters for downstream tasks. Compared to GPT-3 175B ﬁne-tuned with Adam, LoRA can reduce the number of trainable parameters by 10,000 times and the GPU memory requirement by 3 times. LoRA performs on-par or better than ﬁne-tuning in model quality on RoBERTa, DeBERTa, GPT-2, and GPT-3, despite having fewer trainable parameters, a higher training throughput, and, unlike adapters, no additional inference latency. We also provide an empirical investigation into rank-deﬁciency in language model adaptation, which sheds light on the efﬁcacy of LoRA. We release a package that facilitates the integration of LoRA with PyTorch models and provide our implementations and model checkpoints for RoBERTa, DeBERTa, and GPT-2 at https://github.com/microsoft/LoRA.

摘要自然语言处理的一个关键方法是在广泛的数据集上进行大规模预训练，然后针对特定任务或领域进行调整。随着模型规模的增大，对所有参数进行全面微调变得不再实际。以拥有 1750 亿参数的 GPT-3 为例，为每个任务单独部署一个微调后的模型，每个模型都包含 1750 亿参数，这样的成本是难以承受的。为此，我们提出了低秩适应（LoRA）方法，该方法保持预训练模型的权重不变，并在 Transformer 模型的每一层引入可调整的秩分解矩阵，从而显著减少了下游任务所需的可训练参数数量。与使用 Adam 优化器微调的 GPT-3 175B 相比，LoRA 能够将可训练参数的数量减少到原来的万分之一，同时将 GPU 内存需求降低到原来的三分之一。尽管 LoRA 的可训练参数更少，训练速度更快，且不会像适配器那样增加推理延迟，但它在模型性能上与全面微调相当甚至更优，适用于 RoBERTa、DeBERTa、GPT-2 和 GPT-3 等模型。我们还通过实证研究探讨了语言模型适应过程中的秩缺陷问题，这有助于理解 LoRA 的有效性。我们提供了一个工具包，方便将 LoRA 集成到 PyTorch 模型中，并在 https://github.com/microsoft/LoRA 上分享了我们的实现方法以及 RoBERTa、DeBERTa 和 GPT-2 的模型检查点。

[microsoft/LoRA: Code for loralib, an implementation of "LoRA: Low-Rank Adaptation of Large Language Models"](https://github.com/microsoft/LoRA)

### 01. Introduction

Many applications in natural language processing rely on adapting one large-scale, pre-trained language model to multiple down-stream applications. Such adaptation is usually done via ﬁne-tuning, which updates all the parameters of the pre-trained model. The major downside of ﬁne-tuning is that the new model contains as many parameters as in the original model. As larger models are trainedevery few months, this changes from a mere "inconvenience" for GPT-2 (Radford et al., b) or RoBERTa large (Liu et al., 2019) to a critical deployment challenge for GPT-3 (Brown et al., 2020) with 175 billion trainable parameters.1

Many sought to mitigate this by adapting only some parameters or learning external modules for new tasks. This way, we only need to store and load a small number of task-speciﬁc parameters in addition to the pre-trained model for each task, greatly boosting the operational efﬁciency when deployed. However, existing techniques often introduce inference latency (Houlsby et al., 2019; Rebufﬁ et al., 2017) by extending model depth or reduce the model's usable sequence length (Li & Liang, 2021; Lester et al., 2021; Hambardzumyan et al., 2020; Liu et al., 2021) (Section 3). More importantly, these method often fail to match the ﬁne-tuning baselines, posing a trade-off between efﬁciency and model quality.

Figure 1: Our reparametrization. We only train A and B.

∗Equal contribution.

0 Compared to V1, this draft includes better baselines, experiments on GLUE, and more on adapter latency.

1 While GPT-3 175B achieves non-trivial performance with few-shot learning, ﬁne-tuning boosts its performance signiﬁcantly as shown in Appendix A.

在自然语言处理领域，许多应用都依赖于将一个大规模的预训练语言模型适配到多个下游任务中。这种适配过程通常采用微调技术，即对预训练模型的所有参数进行更新。然而，微调的一个主要缺点是，新模型将继承原始模型的全部参数数量。随着每隔几个月就有更大规模的模型被训练出来，这一问题从 GPT-2（Radford 等人，b）或 RoBERTa large（Liu 等人，2019）时期的「小麻烦」，变成了拥有 1750 亿可训练参数的 GPT-3（Brown 等人，2020）所面临的重大部署挑战。

为了解决这一问题，研究者们尝试仅调整部分参数或为新任务学习外部模块。这样，我们只需为每个任务额外存储和加载少量特定于任务的参数，从而在部署时大幅提升操作效率。然而，现有技术往往通过增加模型深度来引入推理延迟（Houlsby 等人，2019；Rebuffi 等人，2017），或者通过缩短模型的可用序列长度（Li & Liang，2021；Lester 等人，2021；Hambardzumyan 等人，2020；Liu 等人，2021）（见第 3 节）来实现。更关键的是，这些方法往往无法达到微调基线的性能水平，从而在效率和模型质量之间形成了一种权衡。

图 1 展示了我们的重参数化方法，其中我们仅对 A 和 B 进行训练。

∗表示同等贡献。

0 与 V1 版本相比，本草案增加了更好的基线比较，GLUE 数据集上的实验，以及更多关于适配器延迟的讨论。

1 尽管 GPT-3 175B 在少样本学习中取得了不错的性能，但如附录 A 所示，通过微调可以显著提升其性能。

We take inspiration from Li et al. (2018a); Aghajanyan et al. (2020) which show that the learned over-parametrized models in fact reside on a low intrinsic dimension. We hypothesize that the change in weights during model adaptation also has a low "intrinsic rank" , leading to our proposed Low-Rank Adaptation (LoRA) approach. LoRA allows us to train some dense layers in a neural network indirectly by optimizing rank decomposition matrices of the dense layers' change during adaptation instead, while keeping the pre-trained weights frozen, as shown in Figure 1. Using GPT-3 175B as an example, we show that a very low rank (i.e., r in Figure 1 can be one or two) sufﬁces even when the full rank (i.e., d) is as high as 12,288, making LoRA both storage- and compute-efﬁcient.

LoRA possesses several key advantages.

- A pre-trained model can be shared and used to build many small LoRA modules for different tasks. We can freeze the shared model and efﬁciently switch tasks by replacing the matrices A and B in Figure 1, reducing the storage requirement and task-switching overhead signiﬁcantly.

- LoRA makes training more efﬁcient and lowers the hardware barrier to entry by up to 3 times when using adaptive optimizers since we do not need to calculate the gradients or maintain the optimizer states for most parameters. Instead, we only optimize the injected, much smaller low-rank matrices.

- Our simple linear design allows us to merge the trainable matrices with the frozen weights when deployed, introducing no inference latency compared to a fully ﬁne-tuned model, by construction.

- LoRA is orthogonal to many prior methods and can be combined with many of them, such as preﬁx-tuning. We provide an example in Appendix E.

我们从 Li 等人（2018a）和 Aghajanyan 等人（2020）的研究中得到启发，这些研究发现，尽管模型参数众多，但它们实际上存在于一个较低的维度空间中。基于这一发现，我们提出了一个假设：在模型调整过程中，权重的变化也遵循一个较低的「内在秩」规律。这一假设催生了我们的低秩适应（LoRA）方法。LoRA 方法的核心在于，它允许我们在不改变预训练模型权重的情况下，通过调整密集层变化的小型秩分解矩阵来训练神经网络的某些部分，这一过程在图 1 中有详细展示。以 GPT-3 175B 为例，我们证明了即使模型的全秩（d）高达 12,288，我们仍然可以使用非常低的秩（r，例如一或二）来实现高效的学习，这使得 LoRA 在存储和计算资源的使用上都极为高效。

LoRA 方法的几个关键优势包括：

- 预训练的模型可以被广泛共享，并用于为不同任务创建多个小型的 LoRA 模块。通过冻结共享模型，并简单地替换图 1 中的矩阵 A 和 B，我们能够快速地在不同任务之间切换，这大大减少了存储需求和任务切换所需的时间。

- LoRA 方法使得训练过程更加高效，并且通过减少对硬件的要求，使得使用自适应优化器的门槛降低了三倍。这是因为我们不需要为大部分参数计算梯度或维护优化器状态，而是专注于优化那些更小、更关键的低秩矩阵。

- 我们的设计是基于简单的线性原理，这意味着在模型部署时，我们可以将可训练的矩阵与冻结的权重合并，从而在推理时不会引入任何延迟，这与完全微调的模型相比，性能是一致的。

- LoRA 方法与许多现有的技术是兼容的，并且可以与它们结合使用，例如前缀调优。我们在附录 E 中提供了一个结合使用的示例。

Terminologies and Conventions 

We make frequent references to the Transformer architecture and use the conventional terminologies for its dimensions. We call the input and output dimension size of a Transformer layer dmodel. We use Wq, Wk, Wv, and Wo to refer to the query/key/value/output projection matrices in the self-attention module. W or W0 refers to a pretrained weight matrix and ∆W its accumulated gradient update during adaptation. We use r to denote the rank of a LoRA module. We follow the conventions set out by (Vaswani et al., 2017; Brown et al., 2020) and use Adam (Loshchilov & Hutter, 2019; Kingma & Ba, 2017) for model optimization and use a Transformer MLP feedforward dimension dffn = 4 × dmodel.

术语和约定

我们在讨论中经常提到 Transformer 架构，并采用其标准术语来描述其维度特性。例如，我们用 dmodel 来表示 Transformer 层的输入和输出维度的大小。在自注意力模块中，我们用 Wq、Wk、Wv 和 Wo 来代表查询、键、值和输出这四个关键的投影矩阵。W 或 W0 代表预训练的权重矩阵，而 ∆W 则代表在模型适应过程中累积的梯度更新。我们用 r 来表示 LoRA 模块的秩。在模型优化方面，我们遵循 (Vaswani et al., 2017; Brown et al., 2020) 所确立的规范，并采用 Adam 优化算法 (Loshchilov & Hutter, 2019; Kingma & Ba, 2017)。此外，我们使用的 Transformer MLP 前馈网络的维度大小 dffn 是 dmodel 的四倍，即 dffn = 4 × dmodel。

### 02. Problem Statement

While our proposal is agnostic to training objective, we focus on language modeling as our motivating use case. Below is a brief description of the language modeling problem and, in particular, the maximization of conditional probabilities given a task-speciﬁc prompt.

Suppose we are given a pre-trained autoregressive language model PΦ(y|x) parametrized by Φ. For instance, PΦ(y|x) can be a generic multi-task learner such as GPT (Radford et al., b; Brown et al., 2020) based on the Transformer architecture (Vaswani et al., 2017). Consider adapting this pre-trained model to downstream conditional text generation tasks, such as summarization, machine reading comprehension (MRC), and natural language to SQL (NL2SQL). Each downstream task is represented by a training dataset of context-target pairs: Z = {(xi, yi)}i=1,..,N , where both xi and yi are sequences of tokens. For example, in NL2SQL, xi is a natural language query and yi its corresponding SQL command; for summarization, xi is the content of an article and yi its summary.

During full ﬁne-tuning, the model is initialized to pre-trained weights Φ0 and updated to Φ0 + ∆Φ by repeatedly following the gradient to maximize the conditional language modeling objective:

One of the main drawbacks for full ﬁne-tuning is that for each downstream task, we learn a different set of parameters ∆Φ whose dimension |∆Φ| equals |Φ0|. Thus, if the pre-trained model is large (such as GPT-3 with |Φ0| ≈ 175 Billion), storing and deploying many independent instances of ﬁne-tuned models can be challenging, if at all feasible.

In this paper, we adopt a more parameter-efﬁcient approach, where the task-speciﬁc parameter increment ∆Φ = ∆Φ(Θ) is further encoded by a much smaller-sized set of parameters Θ with |Θ| << |Φ0|. The task of ﬁnding ∆Φ thus becomes optimizing over Θ:

In the subsequent sections, we propose to use a low-rank representation to encode ∆Φ that is both compute- and memory-efﬁcient. When the pre-trained model is GPT-3 175B, the number of trainable parameters |Θ| can be as small as 0.01% of |Φ0|.

02 问题陈述

我们的提案对训练目标保持中立，但特别关注语言建模作为核心应用场景。以下是对语言建模问题的简要概述，尤其是如何通过特定任务的提示来最大化条件概率。

想象一下，我们拥有一个由 Φ 参数化的预训练自回归语言模型 PΦ(y|x)。这个模型可以是基于 Transformer 架构（Vaswani et al., 2017）的通用多任务学习器，比如 GPT（Radford et al., b; Brown et al., 2020）。现在，我们想将这个预训练模型用于各种下游任务，比如生成文章摘要、理解机器阅读内容，或者将自然语言转换为 SQL 命令。每个任务都由一系列上下文-目标对组成，记作 Z = {(xi, yi)} i=1,..,N，其中 xi 和 yi 都是由 Token 组成的序列。例如，在 NL2SQL 任务中，xi 是一条自然语言查询，而 yi 是对应的 SQL 命令；在摘要任务中，xi 是一篇文章的内容，yi 则是该文章的摘要。

在完全微调过程中，模型首先使用预训练的权重 Φ0 进行初始化，然后通过不断调整参数至 Φ0 + ∆Φ，以最大化条件语言建模的目标。

完全微调的一个显著问题是，每个下游任务都需要学习一组新的参数 ∆Φ，其大小与预训练模型的参数 Φ0 相同。这意味着，如果预训练模型非常庞大（比如拥有约 1750 亿参数的 GPT-3），存储和部署多个微调后的模型实例将变得非常困难，甚至可能不可行。

在本文中，我们提出了一种更为参数高效的方法，其中任务特定的参数增量 ∆Φ 被进一步编码为一组更小的参数 Θ，其大小远小于 Φ0，即 |Θ| << |Φ0|。这样一来，寻找 ∆Φ 的任务就转变为对 Θ 的优化过程。

在接下来的章节中，我们建议采用低秩表示来编码 ∆Φ，这种方法在计算和内存使用上都极为高效。以 GPT-3 175B 这样的预训练模型为例，通过这种方法，可训练参数的数量 |Θ| 可以大幅减少，仅占原始参数 |Φ0 | 的 0.01%。

### 03. Aren't Existing Solution Good Enough

The problem we set out to tackle is by no means new. Since the inception of transfer learning, dozens of works have sought to make model adaptation more parameter- and compute-efﬁcient. See Section 6 for a survey of some of the well-known works. Using language modeling as an example, there are two prominent strategies when it comes to efﬁcient adaptations: adding adapter layers (Houlsby et al., 2019; Rebufﬁ et al., 2017; Pfeiffer et al., 2021; R¨uckl´e et al., 2020) or optimizing some forms of the input layer activations (Li & Liang, 2021; Lester et al., 2021; Hambardzumyan et al., 2020; Liu et al., 2021). However, both strategies have their limitations, especially in a large-scale and latency-sensitive production scenario.

03 现有的解决方案还不够好吗？

我们所关注的问题并非前所未有。自迁移学习问世以来，已有众多研究致力于提高模型适应过程中的参数和计算效率。关于这些研究的具体内容，请参阅第 6 节。以语言模型为例，目前有两种主流的高效适应策略：一是增加适配器层（Houlsby et al., 2019; Rebufﬁ et al., 2017; Pfeiffer et al., 2021; R¨uckl´e et al., 2020），二是优化输入层激活的某些形式（Li & Liang, 2021; Lester et al., 2021; Hambardzumyan et al., 2020; Liu et al., 2021）。然而，这两种策略在大规模和延迟敏感的生产环境中都存在一定的局限性。

Adapter Layers Introduce Inference Latency 

There are many variants of adapters. We focus on the original design by Houlsby et al. (2019) which has two adapter layers per Transformer block and a more recent one by Lin et al. (2020) which has only one per block but with an additional LayerNorm (Ba et al., 2016). While one can reduce the overall latency by pruning layers or exploiting multi-task settings (R¨uckl´e et al., 2020; Pfeiffer et al., 2021), there is no direct ways to bypass the extra compute in adapter layers. This seems like a non-issue since adapter layers are designed to have few parameters (sometimes <1% of the original model) by having a small bottleneck dimension, which limits the FLOPs they can add. However, large neural networks rely on hardware parallelism to keep the latency low, and adapter layers have to be processed sequentially. This makes a difference in the online inference setting where the batch size is typically as small as one. In a generic scenario without model parallelism, such as running inference on GPT-2 (Radford et al., b) medium on a single GPU, we see a noticeable increase in latency when using adapters, even with a very small bottleneck dimension (Table 1).

This problem gets worse when we need to shard the model as done in Shoeybi et al. (2020); Lepikhin et al. (2020), because the additional depth requires more synchronous GPU operations such as AllReduce and Broadcast, unless we store the adapter parameters redundantly many times.

适配器层引入推理延迟

有许多适配器的变体。我们专注于 Houlsby 等人（2019）的原始设计，该设计在每个 Transformer 块中有两个适配器层，以及 Lin 等人（2020）的一个更新的设计，该设计在每个块中只有一个适配器层，但有一个额外的 LayerNorm（Ba 等人，2016）。虽然可以通过修剪层或利用多任务设置（R¨uckl´e 等人，2020；Pfeiffer 等人，2021）来减少总体延迟，但没有直接的方法来绕过适配器层中的额外计算。这似乎不是一个问题，因为适配器层被设计为具有很少的参数（有时 < 1% 的原始模型），通过具有小的瓶颈维度，这限制了它们可以添加的 FLOPs。然而，大型神经网络依赖于硬件并行性来保持低延迟，而适配器层需要按顺序进行处理。这使得在线推理设置中出现了差异，因为批量大小通常仅为一个。在没有模型并行性的通用场景中，例如在单个 GPU 上运行 GPT-2（Radford 等人，b）中等规模的推理，我们发现在使用适配器时，即使是非常小的瓶颈维度，延迟也会显著增加（表 1）。

当我们需要像 Shoeybi 等人（2020）；Lepikhin 等人（2020）那样分片模型时，这个问题变得更糟，因为额外的深度需要更多的同步 GPU 操作，如 AllReduce 和 Broadcast，除非我们多次重复存储适配器参数。

Directly Optimizing the Prompt is Hard 

The other direction, as exempliﬁed by preﬁx tuning (Li & Liang, 2021), faces a different challenge. We observe that preﬁx tuning is difﬁcult to optimize and that its performance changes non-monotonically in trainable parameters, conﬁrming similar observations in the original paper. More fundamentally, reserving a part of the sequence length for adaptation necessarily reduces the sequence length available to process a downstream task, which we suspect makes tuning the prompt less performant compared to other methods. We defer the study on task performance to Section 5.

Table 1: Infernece latency of a single forward pass in GPT-2 medium measured in milliseconds, averaged over 100 trials. We use an NVIDIA Quadro RTX8000. "|Θ|" denotes the number of trainable parameters in adapter layers. AdapterL and AdapterH are two variants of adapter tuning, which we describe in Section 5.1. The inference latency introduced by adapter layers can be signiﬁcant in an online, short-sequence-length scenario. See the full study in Appendix B.

直接对提示进行优化是具有挑战性的。

在另一个方向上，例如通过前缀调优（Li & Liang, 2021）所展示的，我们遇到了新的挑战。我们发现前缀调优的优化过程充满困难，其性能在可训练参数上的变化呈现出非单调性，这一点与原始论文中的观察结果相吻合。更为根本的是，为了适应性而预留一部分序列长度，必然会减少用于处理下游任务的序列长度，这让我们怀疑，与其他方法相比，调优提示的性能可能会受到影响。关于任务性能的详细研究，我们将在第 5 节中进行。

表 1 展示了在 GPT-2 中等模型中单次前向传递的推理延迟，单位为毫秒，数据是基于 100 次试验的平均值。我们使用的是 NVIDIA Quadro RTX8000。"|Θ|" 代表适配器层中可训练参数的数量。AdapterL 和 AdapterH 是适配器调优的两个变体，我们将在第 5.1 节中详细介绍。在在线场景下，特别是在处理短序列长度时，适配器层可能会引入显著的推理延迟。完整的详细研究可以在附录 B 中查阅。

### 04. Our Method

We describe the simple design of LoRA and its practical beneﬁts. The principles outlined here apply to any dense layers in deep learning models, though we only focus on certain weights in Transformer language models in our experiments as the motivating use case.

04 我们的方法

我们详细介绍了 LoRA 的简洁设计及其在实际应用中的优势。这里所阐述的原则适用于深度学习模型中的任何密集层，尽管在我们的实验中，我们特别关注了 Transformer 语言模型中的某些权重，将其作为激发我们研究兴趣的用例。

4.1 Low-Rank-Parameterized Update Matrices

A neural network contains many dense layers which perform matrix multiplication. The weight matrices in these layers typically have full-rank. When adapting to a speciﬁc task, Aghajanyan et al. (2020) shows that the pre-trained language models have a low "instrisic dimension" and can still learn efﬁciently despite a random projection to a smaller subspace. Inspired by this, we hypothesize the updates to the weights also have a low "intrinsic rank" during adaptation. For a pre-trained weight matrix W0 ∈ Rd×k, we constrain its update by representing the latter with a low-rank decomposition W0 + ∆W = W0 + BA, where B ∈ Rd×r, A ∈ Rr×k, and the rank r (cid:28) min(d, k).

During training, W0 is frozen and does not receive gradient updates, while A and B contain trainable parameters. Note both W0 and ∆W = BA are multiplied with the same input, and their respective output vectors are summed coordinate-wise. For h = W0x, our modiﬁed forward pass yields:

h = W0x + ∆W x = W0x + BAx (3)

We illustrate our reparametrization in Figure 1. We use a random Gaussian initialization for A and zero for B, so ∆W = BA is zero at the beginning of training. We then scale ∆W x by α/r , where α is a constant in r. When optimizing with Adam, tuning α is roughly the same as tuning the learning rate if we scale the initialization appropriately. As a result, we simply set α to the ﬁrst r we try and do not tune it. This scaling helps to reduce the need to retune hyperparameters when we vary r (Yang & Hu, 2021).

4.1 低秩参数化更新矩阵

神经网络中的多个密集层通过矩阵乘法进行运算。在这些层中，权重矩阵通常具有完整的秩，即它们可以表示所有可能的线性变换。然而，Aghajanyan 等人（2020）的研究发现，预训练的语言模型在适应特定任务时，其内部结构具有较低的「内在维度」，这意味着即使经过随机压缩到更小的维度空间，模型仍然能够高效学习。基于这一发现，我们提出一个假设：在模型适应过程中，权重更新的「内在秩」也是较低的。

为了验证这一假设，我们采用了一种方法：对于预训练的权重矩阵 W0（维度为 d×k），我们限制其更新过程，通过一个低秩分解来表示更新后的权重矩阵 W0 + ∆W，即 W0 + BA，其中 B 是一个维度为 d×r 的矩阵，A 是一个维度为 r×k 的矩阵，且秩 r 远小于 d 和 k 中的最小值。

在训练过程中，原始的权重矩阵 W0 保持不变，不接收任何梯度更新，而矩阵 A 和 B 则包含可训练的参数。值得注意的是，W0 和更新后的权重矩阵∆W = BA 都与相同的输入数据进行矩阵乘法运算，它们的输出向量按元素相加。对于输出向量 h = W0x，我们修改后的前向传播计算如下：

h = W0x + ∆W x = W0x + BAx (3)

我们在图 1 中展示了这种重参数化的过程。我们使用随机高斯分布初始化矩阵 A，而矩阵 B 则初始化为零，因此在训练开始时，更新后的权重矩阵 ∆W = BA 为零。随后，我们对∆W x 进行缩放，缩放因子为 α/r，其中 α 是一个常数。在使用 Adam 优化算法时，调整 α 的效果与调整学习率相似，前提是我们对初始化进行了适当的缩放。因此，我们通常将 α 设置为我们首次尝试的 r 值，并且不对 α 进行额外的调整。这种缩放策略有助于减少在改变秩 r 时对超参数进行重新调整的需求（Yang & Hu, 2021）。

这种方法可以看作是对传统全微调方法的一种推广，它允许我们在保持模型性能的同时，更有效地利用模型的内在结构。

A Generalization of Full Fine-tuning. 

A more general form of ﬁne-tuning allows the training of a subset of the pre-trained parameters. LoRA takes a step further and does not require the accumulated gradient update to weight matrices to have full-rank during adaptation. This means that when applying LoRA to all weight matrices and training all biases2, we roughly recover the expressiveness of full ﬁne-tuning by setting the LoRA rank r to the rank of the pre-trained weight matrices. In other words, as we increase the number of trainable parameters 3, training LoRA roughly converges to training the original model, while adapter-based methods converges to an MLP and preﬁx-based methods to a model that cannot take long input sequences.

No Additional Inference Latency. 

When deployed in production, we can explicitly compute and store W = W0 + BA and perform inference as usual. Note that both W0 and BA are in Rd×k. When we need to switch to another downstream task, we can recover W0 by subtracting BA and then adding a different B(cid:48)A(cid:48), a quick operation with very little memory overhead. Critically, this guarantees that we do not introduce any additional latency during inference compared to a ﬁne-tuned model by construction.

2 They represent a negligible number of parameters compared to weights.

3 An inevitability when adapting to hard tasks.

一种更广泛的微调技术允许只对预训练模型参数的一部分进行训练。LoRA 技术在此基础上更进一步，它不需要在适应新任务时，权重矩阵的梯度更新必须保持满秩。这意味着，当我们对所有权重矩阵应用 LoRA 技术并训练所有偏差时，通过将 LoRA 的秩 r 设置为预训练权重矩阵的秩，我们可以大致达到与完全微调相同的模型表达能力。简而言之，随着可训练参数数量的增加，LoRA 训练逐渐接近于原始模型的训练，而基于适配器的方法则趋向于一个多层感知机（MLP），基于前缀的方法则趋向于一个无法处理长序列输入的模型。

在实际应用中，我们可以在推理过程中不增加任何延迟。

在生产环境中部署时，我们可以计算并存储 W = W0 + BA，然后像往常一样进行推理。需要注意的是，W0 和 BA 都在 Rd×k 空间中。当我们需要切换到另一个不同的下游任务时，我们可以通过减去 BA 并添加新的 B'(cid:48) A'(cid:48) 来恢复原始的 W0，这个过程快速且内存开销很小。重要的是，这种方法确保了在推理过程中不会引入比微调模型更多的延迟。

2 偏差参数相对于权重参数来说数量很少，几乎可以忽略。

3 在面对复杂任务时，增加可训练参数的数量是不可避免的。

4.2 Applying LoRA to Transformer

In principle, we can apply LoRA to any subset of weight matrices in a neural network to reduce the number of trainable parameters. In the Transformer architecture, there are four weight matrices in the self-attention module (Wq, Wk, Wv, Wo) and two in the MLP module. We treat Wq (or Wk, Wv) as a single matrix of dimension dmodel × dmodel, even though the output dimension is usually sliced into attention heads. We limit our study to only adapting the attention weights for downstream tasks and freeze the MLP modules (so they are not trained in downstream tasks) both for simplicity and parameter-efﬁciency.We further study the effect on adapting different types of attention weight matrices in a Transformer in Section 7.1. We leave the empirical investigation of adapting the MLP layers, LayerNorm layers, and biases to a future work.

Practical Beneﬁts and Limitations. 

The most signiﬁcant beneﬁt comes from the reduction in memory and storage usage. For a large Transformer trained with Adam, we reduce that VRAM usage by up to 2/3 if r (cid:28) dmodel as we do not need to store the optimizer states for the frozen parameters. On GPT-3 175B, we reduce the VRAM consumption during training from 1.2TB to 350GB. With r = 4 and only the query and value projection matrices being adapted, the checkpoint size is reduced by roughly 10,000× (from 350GB to 35MB)4. This allows us to train with signiﬁcantly fewer GPUs and avoid I/O bottlenecks. Another beneﬁt is that we can switch between tasks while deployed at a much lower cost by only swapping the LoRA weights as opposed to all the parameters. This allows for the creation of many customized models that can be swapped in and out on the ﬂy on machines that store the pre-trained weights in VRAM. We also observe a 25% speedup during training on GPT-3 175B compared to full ﬁne-tuning5 as we do not need to calculate the gradient for the vast majority of the parameters.

LoRA also has its limitations. For example, it is not straightforward to batch inputs to different tasks with different A and B in a single forward pass, if one chooses to absorb A and B into W to eliminate additional inference latency. Though it is possible to not merge the weights and dynamically choose the LoRA modules to use for samples in a batch for scenarios where latency is not critical.

4.2 将 LoRA 应用于 Transformer 模型

原则上，我们可以将 LoRA 技术应用于神经网络中任何部分的权重矩阵，以此来减少需要训练的参数数量。在 Transformer 架构中，自注意力模块包含四个权重矩阵（Wq, Wk, Wv, Wo），而多层感知机（MLP）模块则有两个。尽管输出维度通常会被分割成多个注意力头，我们仍将 Wq（或 Wk, Wv）视为一个维度为 dmodel × dmodel 的整体矩阵。我们的研究重点是仅针对下游任务调整注意力权重，同时冻结 MLP 模块（使其在下游任务中不参与训练），这样做既简化了模型，又提高了参数效率。我们在第 7.1 节中进一步探讨了在 Transformer 中调整不同类型注意力权重矩阵的效果。至于适应 MLP 层、LayerNorm 层和偏差的研究，我们将其留待未来的工作。

实际好处和限制。

最显著的好处是减少了内存和存储的使用。对于使用 Adam 优化器训练的大型 Transformer 模型，如果 r 远小于 dmodel，我们可以将 VRAM 的使用量减少高达 2/3，因为我们不需要为那些被冻结的参数存储优化器状态。在 GPT-3 175B 模型上，我们将训练期间的 VRAM 消耗从 1.2TB 降低到了 350GB。当 r 等于 4，且仅调整查询和值投影矩阵时，模型检查点的大小可以减少大约 10,000 倍（从 350GB 减少到 35MB）。这使得我们能够使用更少的 GPU 进行训练，并避免了 I/O 瓶颈。另一个好处是，在部署模型时，我们可以通过仅交换 LoRA 权重而不是整个模型的参数，以更低的成本在不同任务之间切换。这使得我们能够在存储预训练权重的机器上实时创建和交换多个定制模型。我们还发现，与完全微调相比，在 GPT-3 175B 模型上进行训练时，速度提高了 25%，因为我们不需要为模型中的大部分参数计算梯度。

LoRA 技术同样存在一些局限。例如，如果为了减少推理时的延迟而将参数 A 和 B 整合到 W 中，那么在一次前向计算过程中同时处理多个不同任务的输入就会变得复杂。然而，在延迟不是主要考虑因素的场景下，可以选择不合并这些参数，而是根据批量中的样本动态决定使用哪些 LoRA 模块。

### 05. Empirical Experiments

We evaluate the downstream task performance of LoRA on RoBERTa (Liu et al., 2019), De-BERTa (He et al., 2021), and GPT-2 (Radford et al., b), before scaling up to GPT-3 175B (Brown et al., 2020). Our experiments cover a wide range of tasks, from natural language understanding (NLU) to generation (NLG). Speciﬁcally, we evaluate on the GLUE (Wang et al., 2019) benchmark for RoBERTa and DeBERTa. We follow the setup of Li & Liang (2021) on GPT-2 for a direct comparison and add WikiSQL (Zhong et al., 2017) (NL to SQL queries) and SAMSum (Gliwa et al., 2019) (conversation summarization) for large-scale experiments on GPT-3. See Appendix C for more details on the datasets we use. We use NVIDIA Tesla V100 for all experiments.

05 实证实验

我们首先在 RoBERTa（Liu et al., 2019）、DeBERTa（He et al., 2021）和 GPT-2（Radford et al., b）上测试 LoRA 在各种下游任务中的表现，随后将其扩展应用到拥有 1750 亿参数的 GPT-3（Brown et al., 2020）。实验范围广泛，涉及从自然语言理解（NLU）到自然语言生成（NLG）的多种任务。特别地，我们针对 RoBERTa 和 DeBERTa 在 GLUE（Wang et al., 2020）基准上进行了评估。为了与 Li & Liang（2021）在 GPT-2 上的研究进行直接对比，我们采用了相同的实验设置，并额外引入了 WikiSQL（Zhong et al., 2017）（将自然语言转换为 SQL 查询）和 SAMSum（Gliwa et al., 2019）（对话摘要）数据集，用于 GPT-3 的大规模实验。更多关于所使用数据集的详细信息，请参阅附录 C。所有实验均使用 NVIDIA Tesla V100 GPU 进行。

5.1 Baselines

To compare with other baselines broadly, we replicate the setups used by prior work and reuse their reported numbers whenever possible. This, however, means that some baselines might only appear in certain experiments.

Fine-Tuning (FT) is a common approach for adaptation. During ﬁne-tuning, the model is initialized to the pre-trained weights and biases, and all model parameters undergo gradient updates.A simple variant is to update only some layers while freezing others. We include one such baseline reported in prior work (Li & Liang, 2021) on GPT-2, which adapts just the last two layers (FTTop2).

4 We still need the 350GB model during deployment; however, storing 100 adapted models only requires 350GB + 35MB * 100 ≈ 354GB as opposed to 100 * 350GB ≈ 35TB.

5 For GPT-3 175B, the training throughput for full ﬁne-tuning is 32.5 tokens/s per V100 GPU; with the same number of weight shards for model parallelism, the throughput is 43.1 tokens/s per V100 GPU for LoRA.

Table 2: RoBERTabase, RoBERTalarge, and DeBERTaXXL with different adaptation methods on the GLUE benchmark. We report the overall (matched and mismatched) accuracy for MNLI, Matthew's correlation for CoLA, Pearson correlation for STS-B, and accuracy for other tasks. Higher is better for all metrics. * indicates numbers published in prior works. † indicates runs conﬁgured in a setup similar to Houlsby et al. (2019) for a fair comparison.

Bias-only or BitFit is a baseline where we only train the bias vectors while freezing everything else. Contemporarily, this baseline has also been studied by BitFit (Zaken et al., 2021).

Preﬁx-embedding tuning (PreEmbed) inserts special tokens among the input tokens. These special tokens have trainable word embeddings and are generally not in the model's vocabulary. Where to place such tokens can have an impact on performance. We focus on "preﬁxing" , which prepends such tokens to the prompt, and "inﬁxing" , which appends to the prompt; both are discussed in Li & Liang (2021). We use lp (resp. li) denote the number of preﬁx (resp. inﬁx) tokens. The number of trainable parameters is |Θ| = dmodel × (lp + li).

Preﬁx-layer tuning (PreLayer) is an extension to preﬁx-embedding tuning. Instead of just learning the word embeddings (or equivalently, the activations after the embedding layer) for some special tokens, we learn the activations after every Transformer layer. The activations computed from previous layers are simply replaced by trainable ones. The resulting number of trainable parameters is |Θ| = L × dmodel × (lp + li), where L is the number of Transformer layers.

Adapter tuning as proposed in Houlsby et al. (2019) inserts adapter layers between the self-attention module (and the MLP module) and the subsequent residual connection. There are two fully connected layers with biases in an adapter layer with a nonlinearity in between. We call this original design AdapterH. Recently, Lin et al. (2020) proposed a more efﬁcient design with the adapter layer applied only after the MLP module and after a LayerNorm. We call it AdapterL. This is very similar to another deign proposed in Pfeiffer et al. (2021), which we call AdapterP. We also include another baseline call AdapterDrop (R¨uckl´e et al., 2020) which drops some adapter layers for greater efﬁciency (AdapterD). We cite numbers from prior works whenever possible to maximize the number of baselines we compare with; they are in rows with an asterisk (*) in the ﬁrst column. In all cases, we have |Θ| = ˆLAdpt× (2× dmodel× r + r + dmodel) + 2× ˆLLN × dmodel where ˆLAdpt is the number of adapter layers and ˆLLN the number of trainable LayerNorms (e.g., in AdapterL).

LoRA adds trainable pairs of rank decomposition matrices in parallel to existing weight matrices. As mentioned in Section 4.2, we only apply LoRA to Wq and Wv in most experiments for simplicity. The number of trainable parameters is determined by the rank r and the shape of the original weights: |Θ| = 2× ˆLLoRA × dmodel × r, where ˆLLoRA is the number of weight matrices we apply LoRA to.

Table 3: GPT-2 medium (M) and large (L) with different adaptation methods on the E2E NLG Challenge. For all metrics, higher is better. LoRA outperforms several baselines with comparable or fewer trainable parameters. Conﬁdence intervals are shown for experiments we ran. * indicates numbers published in prior works.

5.1 基线

为了全面比较 LoRA 与其他方法，我们尽可能地复制了先前研究中的实验设置，并采用了他们报告的结果作为参考。但这也意味着，某些基线方法仅适用于特定的实验场景。

微调（FT）是一种常用的模型适应方法。在微调过程中，模型以预训练的权重和偏差为起点，所有模型参数都会根据梯度进行更新。微调的一个变种是只更新部分层，而保持其他层的参数不变。我们在 GPT-2 上采用了 Li & Liang（2021）报告中的一种基线方法，该方法仅更新模型的最后两层（FTTop2）。

4 尽管在部署时我们仍需使用 350GB 的模型，但通过 LoRA 方法，存储 100 个经过适应的模型仅需 350GB + 35MB * 100 ≈ 354GB 的空间，远小于传统方法所需的 100 * 350GB ≈ 35TB。

5 对于拥有 1750 亿参数的 GPT-3，全模型微调的训练吞吐量为每 V100 GPU 32.5 个令牌 / 秒；而采用 LoRA 方法，在保持相同模型并行权重分片数量的情况下，训练吞吐量提升至每 V100 GPU 43.1 个令牌 / 秒。

表 2：RoBERTa-base、RoBERTa-large 与 DeBERTaXXL 采用不同适应方法在 GLUE 基准测试中的表现。我们报告了 MNLI 任务的整体准确率（包括匹配和不匹配情况），CoLA 任务的 Matthew's 相关性，STS-B 任务的 Pearson 相关性，以及剩余任务的准确率。所有指标的数值越高表示性能越好。* 表示先前研究中发布的数字。† 表示在类似 Houlsby et al. (2019) 的设置下进行的运行，以确保公平比较。

仅偏置或 BitFit 是一种基线方法，我们仅训练偏置向量，同时保持其他所有参数不变。近期，BitFit（Zaken et al., 2021）也对此基线进行了研究。

前缀嵌入调整（PreEmbed）在输入令牌中插入特殊令牌。这些特殊令牌具有可训练的词嵌入，通常不在模型的词汇表中。这些令牌的放置位置可能会影响性能。我们专注于「前缀」方法，即在提示前添加这些令牌，以及「插入」方法，即在提示后添加这些令牌；这两种方法在 Li & Liang (2021) 中均有讨论。我们分别使用 lp 和 li 来表示前缀和插入令牌的数量。可训练参数的数量为 |Θ| = dmodel × (lp + li)。

前缀层调整（PreLayer）是前缀嵌入调整的扩展。我们不仅学习特殊令牌的词嵌入（即嵌入层后的激活），还学习每个 Transformer 层的激活。从前一层计算出的激活直接被可训练的激活替换。可训练参数的数量为 |Θ| = L × dmodel × (lp + li)，其中 L 表示 Transformer 层的数量。

Houlsby 等人（2019）提出的适配器调优方法是在自注意力模块（和 MLP 模块）与随后的残差连接之间插入适配器层。这些适配器层包含两个带有偏置的全连接层，中间夹着一个非线性层。我们称这种原始设计为 AdapterH。近期，Lin 等人（2020）提出了一种更为高效的适配器设计，即 AdapterL，它仅在 MLP 模块和 LayerNorm 之后应用适配器层。这与 Pfeiffer 等人（2021）提出的 AdapterP 设计非常相似。此外，我们还考虑了 AdapterDrop（Rücklé 等人，2020）作为基线，它通过省略部分适配器层来提高效率，称为 AdapterD。我们尽可能地引用先前研究中的数据，以便与尽可能多的基线进行比较；这些数据在表格第一列带有星号（*）的行中给出。在所有情况下，适配器的可训练参数总数 |Θ| 可以通过以下公式计算：|Θ| = ˆLAdpt × (2 × dmodel × r + r + dmodel) + 2 × ˆLLN × dmodel，其中 ˆLAdpt 表示适配器层的数量，而 ˆLLN 表示可训练的 LayerNorms 的数量（例如，在 AdapterL 中）。

LoRA 方法在现有的权重矩阵旁边并行添加了可训练的秩分解矩阵对。如第 4.2 节所述，为了简化实验，我们在大多数情况下仅将 LoRA 应用于 Wq 和 Wv。可训练参数的数量取决于秩 r 和原始权重的形状，计算公式为：|Θ| = 2 × ˆLLoRA × dmodel × r，其中 ˆLLoRA 是我们应用 LoRA 的权重矩阵的数量。

表 3 展示了 GPT-2 中等（M）和大型（L）模型使用不同适应方法在 E2E NLG 挑战上的性能。所有指标都是越高越好。LoRA 方法在可比较或更少的可训练参数下，超越了多个基线。我们实验结果的置信区间也在表中给出。* 表示这些数据来自先前的研究。

5.2 ROBERTA BASE/LARGE

RoBERTa (Liu et al., 2019) optimized the pre-training recipe originally proposed in BERT (Devlin et al., 2019a) and boosted the latter's task performance without introducing many more trainable parameters. While RoBERTa has been overtaken by much larger models on NLP leaderboards such as the GLUE benchmark (Wang et al., 2019) in recent years, it remains a competitive and popular pre-trained model for its size among practitioners. We take the pre-trained RoBERTa base (125M) and RoBERTa large (355M) from the HuggingFace Transformers library (Wolf et al., 2020) and evaluate the performance of different efﬁcient adaptation approaches on tasks from the GLUE benchmark. We also replicate Houlsby et al. (2019) and Pfeiffer et al. (2021) according to their setup. To ensure a fair comparison, we make two crucial changes to how we evaluate LoRA when comparing with adapters. First, we use the same batch size for all tasks and use a sequence length of 128 to match the adapter baselines. Second, we initialize the model to the pre-trained model for MRPC, RTE, and STS-B, not a model already adapted to MNLI like the ﬁne-tuning baseline. Runs following this more restricted setup from Houlsby et al. (2019) are labeled with †. The result is presented in Table 2 (Top Three Sections). See Section D.1 for details on the hyperparameters used.

5.2 ROBERTA BASE/LARGE

RoBERTa（由 Liu 等人于 2019 年提出）对 BERT（Devlin 等人于 2019 年提出）的预训练方法进行了优化，提高了其在各种任务上的表现，同时并未大幅增加可训练的参数数量。尽管近年来在自然语言处理（NLP）的 GLUE 排行榜（由 Wang 等人于 2019 年提出）上，RoBERTa 已被更大型的模型超越，但它仍然是实践者中广受欢迎的预训练模型，尤其在其规模范围内表现出色。我们从 HuggingFace Transformers 库（由 Wolf 等人于 2020 年开发）中选取了预训练的 RoBERTa base（拥有 1.25 亿参数）和 RoBERTa large（拥有 3.55 亿参数），并在 GLUE 基准的一系列任务上测试了不同的高效适应方法。我们还按照 Houlsby 等人（2019 年）和 Pfeiffer 等人（2021 年）的实验设置进行了复制。为了保证比较的公正性，我们对 LoRA 与适配器之间的比较进行了两项关键调整。首先，我们对所有任务采用了统一的批量大小和 128 的序列长度，以匹配适配器的基准设置。其次，我们为 MRPC、RTE 和 STS-B 任务初始化模型时，直接使用预训练模型，而不是已经针对 MNLI 任务进行过适应的模型，这与微调基准的做法不同。遵循 Houlsby 等人（2019 年）更严格设置的实验被特别标记。详细结果展示在表 2 的前三个部分。关于实验中使用的超参数的更多细节，请参见附录 D.1 节。

5.3 DEBERTA XXL

DeBERTa (He et al., 2021) is a more recent variant of BERT that is trained on a much larger scale and performs very competitively on benchmarks such as GLUE (Wang et al., 2019) and SuperGLUE (Wang et al., 2020). We evaluate if LoRA can still match the performance of a fully ﬁne-tuned DeBERTa XXL (1.5B) on GLUE. The result is presented in Table 2 (Bottom Section).

See Section D.2 for details on the hyperparameters used.

DeBERTa（由 He 等人于 2021 年提出）是 BERT 的一个更新的变种，它在更大规模的数据上进行训练，并在 GLUE（Wang 等人于 2019 年提出）和 SuperGLUE（Wang 等人于 2020 年提出）等 NLP 基准测试中表现出色。我们研究了 LoRA 是否能够在 GLUE 任务上与完全微调的 DeBERTa XXL（拥有 15 亿参数）的性能相匹配。详细结果展示在表 2 的底部部分。关于实验中使用的超参数的更多细节，请参见附录 D.2 节。

5.4 GPT-2 MEDIUM/LARGE

Having shown that LoRA can be a competitive alternative to full ﬁne-tuning on NLU, we hope to answer if LoRA still prevails on NLG models, such as GPT-2 medium and large (Radford et al.,b). We keep our setup as close as possible to Li & Liang (2021) for a direct comparison. Due to space constraint, we only present our result on E2E NLG Challenge (Table 3) in this section.

See Section F.1 for results on WebNLG (Gardent et al., 2017) and DART (Nan et al., 2020). We include a list of the hyperparameters used in Section D.3.

Table 4: Performance of different adaptation methods on GPT-3 175B. We report the logical form validation accuracy on WikiSQL, validation accuracy on MultiNLI-matched, and Rouge-1/2/L on SAMSum. LoRA performs better than prior approaches, including full ﬁne-tuning. The results on WikiSQL have a ﬂuctuation around ±0.5%, MNLI-m around ±0.1%, and SAMSum around ±0.2/±0.2/±0.1 for the three metrics.

5.4 GPT-2 MEDIUM/LARGE

我们已经证明了 LoRA 在自然语言理解（NLU）领域中可以与完全微调相媲美，现在我们希望探究 LoRA 在自然语言生成（NLG）模型上是否同样表现出色，例如 GPT-2 的中型和大型版本（Radford et al., b）。为了与 Li & Liang（2021）的研究进行直接比较，我们的实验设置尽可能保持一致。由于篇幅有限，我们仅在本节中展示我们在 E2E NLG 挑战赛上的结果（表 3）。

关于 WebNLG（Gardent et al., 2017）和 DART（Nan et al., 2020）的结果，请参阅附录 F.1 节。我们在附录 D.3 节中列出了所使用的超参数列表。

表 4 展示了不同适配方法在 GPT-3 175B 上的性能。我们报告了 WikiSQL 上的逻辑形式验证准确率、MultiNLI-matched 上的验证准确率以及 SAMSum 上的 Rouge-1/2/L 得分。LoRA 的表现优于先前的微调方法。WikiSQL 的结果波动范围在 ±0.5%，MNLI-m 在 ±0.1%，而 SAMSum 在三个指标上的波动范围分别在 ±0.2/±0.2/±0.1。

5.5 SCALING UP TO GPT-3 175B

As a ﬁnal stress test for LoRA, we scale up to GPT-3 with 175 billion parameters. Due to the high training cost, we only report the typical standard deviation for a given task over random seeds, as opposed to providing one for every entry. See Section D.4 for details on the hyperparameters used.

As shown in Table 4, LoRA matches or exceeds the ﬁne-tuning baseline on all three datasets. Note that not all methods beneﬁt monotonically from having more trainable parameters, as shown in Figure 2. We observe a signiﬁcant performance drop when we use more than 256 special tokens for preﬁx-embedding tuning or more than 32 special tokens for preﬁx-layer tuning. This corroborates similar observations in Li & Liang (2021). While a thorough investigation into this phenomenon is out-of-scope for this work, we suspect that having more special tokens causes the input distribution to shift further away from the pre-training data distribution. Separately, we investigate the performance of different adaptation approaches in the low-data regime in Section F.3.

Figure 2: GPT-3 175B validation accuracy vs. number of trainable parameters of several adaptation methods on WikiSQL and MNLI-matched. LoRA exhibits better scalability and task performance. See Section F.2 for more details on the plotted data points.

5.5 扩展到 GPT-3 175B

为了对 LoRA 进行最终的压力测试，我们将规模扩展到拥有 1750 亿参数的 GPT-3。考虑到高昂的训练成本，我们仅报告给定任务在随机种子上的典型标准偏差，而不是为每个条目提供一个。有关所使用的超参数的详细信息，请参阅附录 D.4 节。

如表 4 所示，LoRA 在所有三个数据集上的表现与微调基线相当，甚至在某些情况下更优。值得注意的是，并非所有方法都能从增加可训练参数数量中持续获益，这一点在图 2 中得到了体现。我们发现，当使用超过 256 个特殊令牌进行前缀嵌入调整，或者使用超过 32 个特殊令牌进行前缀层调整时，性能会出现显著下降。这一发现与 Li 和 Liang 在 2021 年的研究结果相呼应。尽管深入探究这一现象并非本文的研究重点，但我们推测，增加特殊令牌的数量可能会导致输入数据的分布与预训练数据的分布之间的差异增大。此外，我们在第 F.3 节中探讨了在数据量较少的情况下，不同适应方法的性能表现。

图 2 展示了 GPT-3 175B 在 WikiSQL 和 MNLI-matched 数据集上的验证准确性，以及几种适应方法的可训练参数数量。LoRA 在可扩展性和任务性能方面表现出色。更多关于图表中数据点的详细信息，请参阅第 F.2 节。

### 06. Related Works

Transformer Language Models.

Transformer (Vaswani et al., 2017) is a sequence-to-sequence architecture that makes heavy use of self-attention. Radford et al. (a) applied it to autoregressive language modeling by using a stack of Transformer decoders. Since then, Transformer-based language models have dominated NLP, achieving the state-of-the-art in many tasks. A new paradigm emerged with BERT (Devlin et al., 2019b) and GPT-2 (Radford et al., b) – both are large Transformer language models trained on a large amount of text – where ﬁne-tuning on task-speciﬁc data after pretraining on general domain data provides a signiﬁcant performance gain compared to training on task-speciﬁc data directly. Training larger Transformers generally results in better performance and remains an active research direction. GPT-3 (Brown et al., 2020) is the largest single Transformer language model trained to-date with 175B parameters.

Prompt Engineering and Fine-Tuning.

While GPT-3 175B can adapt its behavior with just a few additional training examples, the result depends heavily on the input prompt (Brown et al., 2020). This necessitates an empirical art of composing and formatting the prompt to maximize a model's performance on a desired task, which is known as prompt engineering or prompt hacking. Fine-tuning retrains a model pre-trained on general domains to a speciﬁc task Devlin et al. (2019b); Radford et al. (a). Variants of it include learning just a subset of the parameters Devlin et al. (2019b); Collobert & Weston (2008), yet practitioners often retrain all of them to maximize the downstream performance. However, the enormity of GPT-3 175B makes it challenging to perform ﬁne-tuning in the usual way due to the large checkpoint it produces and the high hardware barrier to entry since it has the same memory footprint as pre-training.

Parameter-Efﬁcient Adaptation.

Many have proposed inserting adapter layers between existing layers in a neural network (Houlsby et al., 2019; Rebufﬁ et al., 2017; Lin et al., 2020). Our method uses a similar bottleneck structure to impose a low-rank constraint on the weight updates. The key functional difference is that our learned weights can be merged with the main weights during inference, thus not introducing any latency, which is not the case for the adapter layers (Section 3). A comtenporary extension of adapter is COMPACTER (Mahabadi et al., 2021), which essentially parametrizes the adapter layers using Kronecker products with some predetermined weight sharing scheme. Similarly, combining LoRA with other tensor product-based methods could potentially improve its parameter efﬁciency, which we leave to future work. More recently, many proposed optimizing the input word embeddings in lieu of ﬁne-tuning, akin to a continuous and differentiable generalization of prompt engineering (Li & Liang, 2021; Lester et al., 2021; Hambardzumyan et al., 2020; Liu et al., 2021). We include comparisons with Li & Liang (2021) in our experiment section. However, this line of works can only scale up by using more special tokens in the prompt, which take up available sequence length for task tokens when positional embeddings are learned.

Low-Rank Structures in Deep Learning. 

Low-rank structure is very common in machine learning. A lot of machine learning problems have certain intrinsic low-rank structure (Li et al., 2016; Cai et al., 2010; Li et al., 2018b; Grasedyck et al., 2013). Moreover, it is known that for many deep learning tasks, especially those with a heavily over-parametrized neural network, the learned neural network will enjoy low-rank properties after training (Oymak et al., 2019). Some prior works even explicitly impose the low-rank constraint when training the original neural network (Sainath et al., 2013; Povey et al., 2018; Zhang et al., 2014; Jaderberg et al., 2014; Zhao et al., 2016; Khodak et al., 2021; Denil et al., 2014); however, to the best of our knowledge, none of these works considers low-rank update to a frozen model for adaptation to downstream tasks. In theory literature, it is known that neural networks outperform other classical learning methods, including the corresponding (ﬁnite-width) neural tangent kernels (Allen-Zhu et al., 2019; Li & Liang, 2018) when the underlying concept class has certain low-rank structure (Ghorbani et al., 2020; Allen-Zhu & Li, 2019; Allen-Zhu & Li, 2020a). Another theoretical result in Allen-Zhu & Li (2020b) suggests that low-rank adaptations can be useful for adversarial training. In sum, we believe that our proposed low-rank adaptation update is well-motivated by the literature.

06 相关工作

Transformer 语言模型

Transformer（Vaswani 等人，2017）是一种基于自注意力机制的序列到序列模型，被广泛应用于自回归语言建模，其中使用了多个 Transformer 解码器层（Radford 等人，a）。自此，基于 Transformer 的语言模型在自然语言处理（NLP）领域取得了领先地位，在多项任务中达到了顶尖水平。BERT（Devlin 等人，2019b）和 GPT-2（Radford 等人，b）的出现标志着一种新趋势的兴起，它们都是在大规模文本数据上训练的大型 Transformer 模型。这些模型在通用领域数据上预训练后，通过在特定任务数据上进行微调，能够显著提升性能，与直接在特定任务数据上训练相比。当前，研究者们仍在探索如何通过训练更大规模的 Transformer 模型来进一步提升性能。GPT-3（Brown 等人，2020）是目前已知的最大规模的单个 Transformer 语言模型，拥有惊人的 1750 亿个参数。

提示工程与微调

尽管 GPT-3 175B 能够通过极少量的额外训练样本来调整其行为，但其表现很大程度上依赖于输入的提示（Brown 等人，2020）。因此，如何设计有效的提示以最大化模型在特定任务上的表现，成为了一门实践艺术，这被称为提示工程或提示破解。微调是指将预训练模型进一步调整以适应特定任务的过程（Devlin 等人，2019b；Radford 等人，a）。微调的方法有多种，包括仅调整部分参数（Devlin 等人，2019b；Collobert & Weston，2008），但实践中常常选择重新训练所有参数以追求最佳的下游任务性能。然而，GPT-3 175B 庞大的模型规模给微调带来了挑战，主要是因为微调过程中会产生大量的模型检查点，并且由于模型与预训练时具有相同的内存需求，因此对硬件的要求极高，这构成了一个显著的进入门槛。

参数高效调整

许多研究者提出在神经网络的现有层之间添加适配器层（Houlsby 等人，2019；Rebuffi 等人，2017；Lin 等人，2020）。我们的方法采用了一种类似的瓶颈结构，这种结构对权重更新的方式施加了低秩限制。与适配器层不同，我们的方法在推理过程中可以将学习到的权重与主要权重合并，从而不会增加任何处理时间（详见第 3 节）。适配器层的一个现代变体是 COMPACTER（Mahabadi 等人，2021），它通过使用 Kronecker 积来参数化适配器层，并采用特定的权重共享策略。同样，将 LoRA 与基于张量积的其他方法结合可能会进一步提高模型的参数效率，这将是未来研究的一个方向。最近，一些研究者提出通过优化输入的词嵌入来代替传统的微调方法，这可以看作是提示工程的一种连续且可微分的扩展（Li & Liang，2021；Lester 等人，2021；Hambardzumyan 等人，2020；Liu 等人，2021）。在我们的实验部分，我们与 Li & Liang（2021）的方法进行了比较。然而，这种方法的扩展性受限于在提示中使用更多的特殊标记，这会减少学习位置嵌入时用于任务标记的序列长度。

深度学习中的低秩结构

低秩结构在机器学习领域广泛存在。许多机器学习问题都具有某种内在的低秩特性（Li et al., 2016; Cai et al., 2010; Li et al., 2018b; Grasedyck et al., 2013）。对于许多深度学习任务，尤其是那些拥有过度参数化神经网络的任务，训练后的神经网络往往会展现出低秩的特性（Oymak et al., 2019）。以往的研究甚至在训练神经网络时特意施加低秩限制（Sainath et al., 2013; Povey et al., 2018; Zhang et al., 2014; Jaderberg et al., 2014; Zhao et al., 2016; Khodak et al., 2021; Denil et al., 2014）；尽管如此，据我们所知，这些研究并未涉及对冻结模型进行低秩更新以适应后续任务。在理论研究领域，神经网络因其卓越的性能而广为人知，它们在与其他传统学习方法，包括相应的（有限宽度）神经切线核（Allen-Zhu et al., 2019; Li & Liang, 2018）的比较中脱颖而出，尤其是在底层概念类具有特定低秩结构的情况下（Ghorbani et al., 2020; Allen-Zhu & Li, 2019; Allen-Zhu & Li, 2020a）。Allen-Zhu 和 Li（2020b）的另一项理论研究指出，低秩适应在对抗性训练中可能具有重要作用。综上所述，我们认为提出的低秩适应更新方法是有充分文献支持的。

### 07. Understanding the Low-Rank Updates

Given the empirical advantage of LoRA, we hope to further explain the properties of the low-rank adaptation learned from downstream tasks. Note that the low-rank structure not only lowers the hardware barrier to entry which allows us to run multiple experiments in parallel, but also gives better interpretability of how the update weights are correlated with the pre-trained weights. We focus our study on GPT-3 175B, where we achieved the largest reduction of trainable parameters (up to 10,000×) without adversely affecting task performances.

We perform a sequence of empirical studies to answer the following questions: 1) Given a parameter budget constraint, which subset of weight matrices in a pre-trained Transformer should we adapt to maximize downstream performance? 2) Is the "optimal" adaptation matrix ∆W really rank-deﬁcient? If so, what is a good rank to use in practice? 3) What is the connection between ∆W and W ? Does ∆W highly correlate with W ? How large is ∆W comparing to W?

We believe that our answers to question (2) and (3) shed light on the fundamental principles of using pre-trained language models for downstream tasks, which is a critical topic in NLP.

鉴于 LoRA 在实证研究中展现出的优势，我们旨在深入探讨从下游任务中习得的低秩适应的特性。值得注意的是，低秩结构不仅降低了硬件要求，使得我们能够并行开展多项实验，而且还增强了更新权重与预训练权重之间关联的解释性。我们的研究聚焦于 GPT-3 175B，在此模型中，我们实现了可训练参数的大幅缩减（高达 10,000 倍），同时并未牺牲任务性能。

我们开展了一系列实证研究，旨在解答以下关键问题：1）在参数预算受限的情况下，我们应该调整预训练 Transformer 中的哪些权重矩阵，以最大化下游任务的性能？2）所谓的「最优」适应矩阵 ∆W 是否确实秩不足？若如此，实践中应采用何种秩？3）∆W 与 W 之间存在何种联系？∆W 是否与 W 高度相关？∆W 相对于 W 的大小如何？

我们坚信，对问题（2）和（3）的回答将阐明使用预训练语言模型进行下游任务的基本原则，这一议题在自然语言处理（NLP）领域至关重要。

7.1 WHICH WEIGHT MATRICES IN TRANSFORMER SHOULD WE APPLY LORA TO ?

Given a limited parameter budget, which types of weights should we adapt with LoRA to obtain the best performance on downstream tasks? As mentioned in Section 4.2, we only consider weight matrices in the self-attention module. We set a parameter budget of 18M (roughly 35MB if stored in FP16) on GPT-3 175B, which corresponds to r = 8 if we adapt one type of attention weights or r = 4 if we adapt two types, for all 96 layers. The result is presented in Table 5.

Table 5: Validation accuracy on WikiSQL and MultiNLI after applying LoRA to different types of attention weights in GPT-3, given the same number of trainable parameters. Adapting both Wq and Wv gives the best performance overall. We ﬁnd the standard deviation across random seeds to be consistent for a given dataset, which we report in the ﬁrst column.

Note that putting all the parameters in ∆Wq or ∆Wk results in signiﬁcantly lower performance, while adapting both Wq and Wv yields the best result. This suggests that even a rank of four captures enough information in ∆W such that it is preferable to adapt more weight matrices than adapting a single type of weights with a larger rank.

7.1 我们应该在 Transformer 中对哪些权重矩阵应用 LoRA？

在参数预算有限的情况下，我们应采用 LoRA 适应哪些类型的权重，以优化下游任务的性能？如第 4.2 节所述，我们仅关注自注意力模块中的权重矩阵。在 GPT-3 175B 上，我们设定了 18M 的参数预算（以 FP16 格式存储，约 35MB），若仅适应一种注意力权重，则对应秩 r = 8；若适应两种类型，则为 r = 4，适用于所有 96 层。相关结果详见表 5。

表 5：在 GPT-3 中对不同注意力权重应用 LoRA 后，WikiSQL 和 MultiNLI 的验证准确率，给定相同数量的可训练参数。同时适应 Wq 和 Wv 总体上提供了最佳性能。我们观察到，对于给定的数据集，不同随机种子之间的标准偏差保持一致，我们将其报告在第一列中。

请注意，将所有参数放入∆Wq 或∆Wk 会导致显著较低的性能，而同时适应 Wq 和 Wv 则产生最佳结果。这表明，即使秩为四也足以在 ∆W 中捕获足够的信息，使得适应更多的权重矩阵比适应单一类型的权重具有更大的秩更为可取。

7.2 WHAT IS THE OPTIMAL RANK r FOR LORA ?

We turn our attention to the effect of rank r on model performance. We adapt {Wq, Wv}, {Wq, Wk, Wv, Wc}, and just Wq for a comparison.

Table 6: Validation accuracy on WikiSQL and MultiNLI with different rank r. To our surprise, a rank as small as one sufﬁces for adapting both Wq and Wv on these datasets while training Wq alone needs a larger r. We conduct a similar experiment on GPT-2 in Section H.2.

Table 6 shows that, surprisingly, LoRA already performs competitively with a very small r (more so for {Wq, Wv} than just Wq). This suggests the update matrix ∆W could have a very small "intrinsic rank" .6 To further support this ﬁnding, we check the overlap of the subspaces learned by different choices of r and by different random seeds. We argue that increasing r does not cover a more meaningful subspace, which suggests that a low-rank adaptation matrix is sufﬁcient.

6 However, we do not expect a small r to work for every task or dataset. Consider the following thought experiment: if the downstream task were in a different language than the one used for pre-training, retraining the entire model (similar to LoRA with r = dmodel) could certainly outperform LoRA with a small r.

Subspace similarity between different r. Given Ar=8 and Ar=64 which are the learned adaptation matrices with rank r = 8 and 64 using the same pre-trained model, we perform singular value decomposition and obtain the right-singular unitary matrices UAr=8 and UAr=64.7 We hope to answer: how much of the subspace spanned by the top i singular vectors in UAr=8 (for 1 ≤ i ≤ 8) is contained in the subspace spanned by top j singular vectors of UAr=64 (for 1 ≤ j ≤ 64)? We measure this quantity with a normalized subspace similarity based on the Grassmann distance (See Appendix G for a more formal discussion)

where Ui represents the columns of UAr=8 corresponding to the top-i singular vectors.

φ(·) has a range of [0, 1], where 1 represents a complete overlap of subspaces and 0 a complete separation. See Figure 3 for how φ changes as we vary i and j. We only look at the 48th layer (out of 96) due to space constraint, but the conclusion holds for other layers as well, as shown in Section H.1.

Figure 3: Subspace similarity between column vectors of Ar=8 and Ar=64 for both ∆Wq and ∆Wv. The third and the fourth ﬁgures zoom in on the lower-left triangle in the ﬁrst two ﬁgures. The top directions in r = 8 are included in r = 64, and vice versa.

We make an important observation from Figure 3.

Directions corresponding to the top singular vector overlap signiﬁcantly between Ar=8 and Ar=64, while others do not. Speciﬁcally, ∆Wv (resp. ∆Wq) of Ar=8 and ∆Wv (resp. ∆Wq) of Ar=64 share a subspace of dimension 1 with normalized similarity > 0.5, providing an explanation of why r = 1 performs quite well in our downstream tasks for GPT-3.

Since both Ar=8 and Ar=64 are learned using the same pre-trained model, Figure 3 indicates that the top singular-vector directions of Ar=8 and Ar=64 are the most useful, while other directions potentially contain mostly random noises accumulated during training. Hence, the adaptation matrix can indeed have a very low rank.

Subspace similarity between different random seeds. We further conﬁrm this by plotting the normalized subspace similarity between two randomly seeded runs with r = 64, shown in Figure 4. ∆Wq appears to have a higher "intrinsic rank" than ∆Wv, since more common singular value directions are learned by both runs for ∆Wq, which is in line with our empirical observation in Table 6. As a comparison, we also plot two random Gaussian matrices, which do not share any common singular value directions with each other.

7.2 LoRA 的最佳秩 r 是多少？

我们将注意力转向秩 r 对模型性能的影响。我们比较了适应 {Wq, Wv}，{Wq, Wk, Wv, Wc}，以及仅 Wq 的情况。

表 6：具有不同秩 r 的 WikiSQL 和 MultiNLI 验证准确率。令我们惊讶的是，对于适应 Wq 和 Wv 的这些数据集，即使秩小至一也足够，而单独训练 Wq 则需要更大的 r。我们在附录 H.2 中对 GPT-2 进行了类似的实验。

表 6 显示，令人惊讶的是，LoRA 已经以非常小的 r（特别是对于 {Wq, Wv} 而不是仅 Wq）具有竞争力。这表明更新矩阵 ∆W 可能具有非常小的「内在秩」，即其有效的信息表示可能并不需要高维空间。为了进一步支持这一发现，我们检查了由不同选择的 r 和不同随机种子学习的子空间的交叠。我们认为，增加秩 r 并不会扩展到更有意义的子空间，这表明低秩适应矩阵是足够的。

然而，我们并不期望小 r 在每个任务或数据集上都有效。考虑以下思想实验：如果下游任务使用的是与预训练不同的语言，那么重新训练整个模型（类似于 LoRA 与 r = dmodel）肯定可以胜过具有小 r 的 LoRA。

我们有两个适应矩阵，一个秩为 8（记作 Ar=8），另一个秩为 64（记作 Ar=64），它们都是基于同一个预训练模型学习得到的。我们对这两个矩阵进行了奇异值分解，这是一种数学方法，可以揭示矩阵的内在结构。分解后，我们得到了两个矩阵 UAr=8 和 UAr=64，它们包含了矩阵的重要信息。

我们想要探究的是：UAr=8 中前 8 个最重要的向量所构成的空间，在 UAr=64 中前 64 个最重要的向量所构成的空间中占据了多少比例？为了量化这个比例，我们使用了一种叫做 Grassmann 距离的方法，它可以帮助我们计算两个空间之间的相似度。

这个相似度用一个数值 φ 来表示，它的范围是 0 到 1。如果 φ 接近 1，说明两个空间非常相似，几乎完全重叠；如果 φ 接近 0，说明两个空间几乎没有交集。我们在图 3 中展示了随着我们改变 i 和 j 的值，φ 是如何变化的。这里，i 和 j 分别代表 UAr=8 和 UAr=64 中我们关注的向量数量。

图 3 还展示了我们只关注第 48 层的结果，但这个结论同样适用于其他层，这一点在文章的第 H.1 节中有详细说明。

通过观察图 3，我们发现了一个关键点：Ar=8 和 Ar=64 中最重要的向量（即那些对应于最大奇异值的向量）之间有很高的相似度，而其他向量则没有这种相似性。具体来说，Ar=8 的∆Wv（或∆Wq）和 Ar=64 的∆Wv（或∆Wq）共享一个维度为 1 的子空间，其相似度超过了 0.5。这个发现解释了为什么在我们的任务中，只使用一个向量（即秩为 1）就能取得很好的效果。

由于 Ar=8 和 Ar=64 都是基于同一个预训练模型学习的，图 3 的结果表明，最重要的向量方向是最有用的，而其他方向可能只是训练过程中产生的随机噪声。这意味着，适应矩阵实际上可以非常简单，只需要包含最重要的信息即可。

不同随机种子间的子空间相似性。为了进一步验证这一点，我们绘制了两个随机种子运行之间的归一化子空间相似性图，其中 r 值为 64，如图 4 所示。∆Wq 似乎比 ∆Wv 具有更高的「固有秩」，因为在这两个运行中，∆Wq 学习到了更多共享的奇异值方向，这与我们在表 6 中的实证观察相符。作为对比，我们还绘制了两个随机高斯矩阵的图，它们之间没有共享任何奇异值方向。

7.3 HOW DOES THE ADAPTATION MATRIX ∆W COMPARE TO W ?

We further investigate the relationship between ∆W and W . In particular, does ∆W highly correlate with W ? (Or mathematically, is ∆W mostly contained in the top singular directions of W ?) Also, how "large" is ∆W comparing to its corresponding directions in W ? This can shed light on the underlying mechanism for adapting pre-trained language models.

7 Note that a similar analysis can be carried out with B and the left-singular unitary matrices – we stick with A for our experiments.

Figure 4: Left and Middle: Normalized subspace similarity between the column vectors of Ar=64 from two random seeds, for both ∆Wq and ∆Wv in the 48-th layer. Right: the same heat-map between the column vectors of two random Gaussian matrices. See Section H.1 for other layers.

To answer these questions, we project W onto the r-dimensional subspace of ∆W by computing U(cid:62)W V (cid:62), with U/V being the left/right singular-vector matrix of ∆W . Then, we compare the Frobenius norm between ||UWVF|| and ||WF||. As a comparison, we also compute ||UWVF|| by replacing U, V with the top r singular vectors of W or a random matrix.

Table 7: The Frobenius norm of U(cid:62)WqV (cid:62) where U and V are the left/right top r singular vector directions of either (1) ∆Wq, (2) Wq, or (3) a random matrix. The weight matrices are taken from the 48th layer of GPT-3.

We draw several conclusions from Table 7. First, ∆W has a stronger correlation with W compared to a random matrix, indicating that ∆W ampliﬁes some features that are already in W . Second, instead of repeating the top singular directions of W , ∆W only ampliﬁes directions that are not emphasized in W . Third, the ampliﬁcation factor is rather huge: 21.5 ≈ 6.91/0.32 for r = 4. See Section H.4 for why r = 64 has a smaller ampliﬁcation factor. We also provide a visualization in Section H.3 for how the correlation changes as we include more top singular directions from Wq. This suggests that the low-rank adaptation matrix potentially ampliﬁes the important features for speciﬁc downstream tasks that were learned but not emphasized in the general pre-training model.

7.3 适应矩阵 ∆W 与原始矩阵 W 相比有何不同？

我们深入探究了 ∆W 与 W 之间的关系。具体来说，∆W 是否与 W 高度相关？（或者说，∆W 是否主要位于 W 的最高奇异方向内？）此外，与 W 中的对应方向相比，∆W 的规模如何？这些问题有助于揭示预训练语言模型适应过程中的内在机制。

7 需要注意的是，类似的分析也可以应用于 B 和左奇异酉矩阵，但我们选择在实验中专注于 A。

图 4：左图和中图展示了两个随机种子下 Ar=64 列向量之间的归一化子空间相似性，分别对应于第 48 层的 ∆Wq 和 ∆Wv。右图则是两个随机高斯矩阵列向量之间的相似性热图。关于其他层的信息，请参阅 H.1 节。

为了解答这些问题，我们将 W 投影到 ∆W 的 r 维子空间上，通过计算 U（cid:62）W V（cid:62)，其中 U 和 V 分别是 ∆W 的左奇异向量矩阵和右奇异向量矩阵。接着，我们比较了 ||UWVF|| 和 ||WF|| 之间的 Frobenius 范数。作为对照，我们还计算了 ||UWVF||，其中 U 和 V 被替换为 W 的顶部 r 奇异向量或一个随机矩阵。

表 7：U（cid:62）WqV（cid:62）的 Frobenius 范数，其中 U 和 V 分别是（1）∆Wq、(2）Wq 或（3）随机矩阵的左 / 右顶部 r 奇异向量方向。这些权重矩阵来自 GPT-3 模型的第 48 层。

我们从表 7 中得出几个关键发现。首先，与随机矩阵相比，∆W 与 W 之间的关联性更强，这意味着∆W 增强了 W 中已有的某些特征。其次，∆W 并没有简单地复制 W 的主要特征方向，而是放大了那些在 W 中未被充分强调的方向。放大因子的数值相当显著，对于 r=4，其值约为 21.5，即 6.91 除以 0.32。至于为什么 r=64 时的放大因子较小，我们将在 H.4 节中进行详细解释。此外，我们在 H.3 节中通过可视化展示了随着我们纳入更多来自 Wq 的顶部奇异方向，相关性是如何随之变化的。这些发现暗示，低秩适应矩阵可能放大了那些在通用预训练模型中学习到但对于特定下游任务至关重要的特征，尽管这些特征在预训练阶段并未被特别强调。

### 08. Conclusion and Future Work

Fine-tuning enormous language models is prohibitively expensive in terms of the hardware required and the storage/switching cost for hosting independent instances for different tasks. We propose LoRA, an efﬁcient adaptation strategy that neither introduces inference latency nor reduces input sequence length while retaining high model quality. Importantly, it allows for quick task-switching when deployed as a service by sharing the vast majority of the model parameters. While we focused on Transformer language models, the proposed principles are generally applicable to any neural networks with dense layers.

There are many directions for future works. 1) LoRA can be combined with other efﬁcient adaptation methods, potentially providing orthogonal improvement. 2) The mechanism behind ﬁne-tuning or LoRA is far from clear – how are features learned during pre-training transformed to do well on downstream tasks? We believe that LoRA makes it more tractable to answer this than full ﬁnetuning. 3) We mostly depend on heuristics to select the weight matrices to apply LoRA to. Are there more principled ways to do it? 4) Finally, the rank-deﬁciency of ∆W suggests that W could be rank-deﬁcient as well, which can also be a source of inspiration for future works.

在结论与未来工作的部分

我们强调了微调大型语言模型所面临的挑战，包括高昂的硬件需求和为不同任务维护独立模型实例的存储与切换成本。为此，我们提出了 LoRA，这是一种高效的模型适应方法，它不会增加推理延迟，也不会缩短输入序列长度，同时保证了模型的质量。LoRA 的另一个重要优势是，在作为服务部署时，它允许快速切换不同的任务，同时共享大部分模型参数，从而提高了灵活性和效率。尽管我们的研究主要集中在 Transformer 语言模型上，但我们提出的 LoRA 原则同样适用于任何包含密集层的神经网络，具有广泛的适用性。

未来的研究有许多可能的方向。1）LoRA 技术可以与其他的优化技术相结合，这种结合可能会带来额外的性能提升，就像不同角度的光线汇聚在一起，照亮了问题的不同方面。2）尽管微调或 LoRA 技术背后的工作原理尚未完全明了，但我们知道，预训练阶段学习到的知识是如何被巧妙地转化，以适应各种特定任务的。LoRA 技术提供了一种更为简洁的方式来探索这一过程，就像用一把精巧的钥匙打开了知识转化的大门。3）目前，我们选择应用 LoRA 的权重矩阵时，主要依赖于经验法则。我们想知道，是否存在更为科学的方法来指导这一选择，就像寻找一把更精确的尺子来衡量知识的深度。4）最后，∆W 矩阵的秩不足现象提示我们，原始的 W 矩阵也可能存在秩不足的情况。这一发现可能成为未来研究的新起点，就像在知识的海洋中发现了一片新的岛屿，等待我们去探索。