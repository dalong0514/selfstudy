## 2023019Attention-Is-All-You-Need

Ashish Vaswani\*
Google Brain
avaswani@google.com

Noam Shazeer\*
Google Brain
noam@google.com

Niki Parmar\*
Google Research
nikip@google.com

Jakob Uszkoreit\*
Google Research
usz@google.com

Llion Jones\*
Google Research
llion@google.com

Aidan N. Gomez\* †
University of Toronto
aidan@cs.toronto.edu

Łukasz Kaiser\*
Google Brain
lukaszkaiser@google.com

Illia Polosukhin\* ‡
illia.polosukhin@gmail.com

### Abstract

The dominant sequence transduction models are based on complex recurrent or convolutional neural networks that include an encoder and a decoder. The best performing models also connect the encoder and decoder through an attention mechanism. We propose a new simple network architecture, the Transformer, based solely on attention mechanisms, dispensing with recurrence and convolutions entirely. Experiments on two machine translation tasks show these models to be superior in quality while being more parallelizable and requiring significantly less time to train. Our model achieves 28.4 BLEU on the WMT 2014 English-to-German translation task, improving over the existing best results, including ensembles, by over 2 BLEU. On the WMT 2014 English-to-French translation task, our model establishes a new single-model state-of-the-art BLEU score of 41.8 after training for 3.5 days on eight GPUs, a small fraction of the training costs of the best models from the literature. We show that the Transformer generalizes well to other tasks by applying it successfully to English constituency parsing both with large and limited training data.

Equal contribution. Listing order is random. Jakob proposed replacing RNNs with self-attention and started the effort to evaluate this idea. Ashish, with Illia, designed and implemented the first Transformer models and has been crucially involved in every aspect of this work. Noam proposed scaled dot-product attention, multi-head attention and the parameter-free position representation and became the other person involved in nearly every detail. Niki designed, implemented, tuned and evaluated countless model variants in our original codebase and tensor2tensor. Llion also experimented with model novel variants, was responsible for our initial codebase, and efficient inference and visualizations. Łukasz and Aidan spent countless long days designing various parts of and implementing tensor2tensor, replacing our earlier codebase, greatly improving results and massively accelerating our research.

†Work performed while at Google Brain.

‡Work performed while at Google Research.

31st Conference on Neural Information Processing Systems (NIPS 2017), Long Beach, CA, USA.

主流的序列处理模型通常基于复杂的循环神经网络或卷积神经网络，这些网络包含编码器和解码器两个主要部分。其中，性能最佳的模型还利用一种称为「注意力机制」的技术来连接编码器和解码器。我们提出了一种全新的、结构简单的网络架构，名为 Transformer。这个模型完全依赖注意力机制，彻底摒弃了循环和卷积结构。

我们在两个机器翻译任务上进行了实验，结果表明 Transformer 模型不仅翻译质量更高，而且更容易并行处理，训练时间也大大缩短。在 2014 年 WMT 英德翻译任务中，我们的模型达到了 28.4 的 BLEU 分数（一种评估机器翻译质量的指标），比现有的最佳成果（包括多个模型组合的结果）提高了 2 分以上。在 2014 年 WMT 英法翻译任务中，我们的模型仅用了 3.5 天时间在 8 个 GPU 上训练，就创造了 41.8 的 BLEU 新纪录，成为当时单个模型的最佳成绩。这个训练成本仅为此前最佳模型的一小部分。

为了证明 Transformer 模型的通用性，我们还将其应用于英语句法结构分析任务。无论是在大规模还是有限的训练数据条件下，Transformer 都表现出色，充分展示了其在其他语言任务上的良好适应能力。

本研究是多位研究者共同努力的成果，以下按随机顺序列出他们的贡献：

Jakob 首先提出用自注意力机制取代传统的循环神经网络，并带头评估这一想法的可行性。Ashish 与 Illia 合作设计并实现了最初的 Transformer 模型，他们在研究的各个环节都发挥了关键作用。Noam 提出了缩放点积注意力、多头注意力等创新概念，以及一种不需要额外参数的位置编码方法，他几乎参与了项目的每一个细节。Niki 在我们最初的代码库和后来的 tensor2tensor 框架中，设计、实现、优化并评估了众多模型变体。Llion 也探索了多种新颖的模型变体，他负责我们最初的代码库，并致力于提高模型的推理效率和可视化效果。Łukasz 和 Aidan 投入了大量时间来设计和实现 tensor2tensor 框架的各个部分，这个框架取代了我们早期的代码库，极大地改善了实验结果，显著加快了我们的研究进度。

## 1 Introduction

Recurrent neural networks, long short-term memory [13] and gated recurrent [7] neural networks in particular, have been firmly established as state of the art approaches in sequence modeling and transduction problems such as language modeling and machine translation [35, 2, 5]. Numerous efforts have since continued to push the boundaries of recurrent language models and encoder-decoder architectures [38, 24, 15].

Recurrent models typically factor computation along the symbol positions of the input and output sequences. Aligning the positions to steps in computation time, they generate a sequence of hidden states $h_t$, as a function of the previous hidden state $h_{t-1}$ and the input for position $t$. This inherently sequential nature precludes parallelization within training examples, which becomes critical at longer sequence lengths, as memory constraints limit batching across examples. Recent work has achieved significant improvements in computational efficiency through factorization tricks [21] and conditional computation [32], while also improving model performance in case of the latter. The fundamental constraint of sequential computation, however, remains.

Attention mechanisms have become an integral part of compelling sequence modeling and transduction models in various tasks, allowing modeling of dependencies without regard to their distance in the input or output sequences [2, 19]. In all but a few cases [27], however, such attention mechanisms are used in conjunction with a recurrent network.

In this work we propose the Transformer, a model architecture eschewing recurrence and instead relying entirely on an attention mechanism to draw global dependencies between input and output. The Transformer allows for significantly more parallelization and can reach a new state of the art in translation quality after being trained for as little as twelve hours on eight P100 GPUs.

循环神经网络，尤其是长短期记忆（LSTM）[13] 和门控循环单元（GRU）[7] 神经网络，已经牢牢地确立了作为序列建模和序列转录问题的最先进方法，例如语言建模和机器翻译 [35,2,5]。此后，许多工作继续推动循环语言模型和编码器-解码器架构的边界 [38,24,15]。

循环模型通常沿输入和输出序列的符号位置分解计算。将位置与计算时间步骤对齐，它们生成一系列隐藏状态 $h_t$，作为前一隐藏状态 $h_{t-1}$ 和位置 $t$ 处输入的函数。这种固有的顺序特性排除了训练样本内的并行化。随着序列长度的增加，这一点变得至关重要，因为内存限制限制了在不同样本之间进行批量处理。最近的工作通过因子分解技巧 [21] 和条件计算 [32] 在计算效率方面取得了显著的改进，同时在后一种情况下也提高了模型性能。然而，顺序计算的根本限制仍然存在。

注意力机制（Attention Mechanism）已成为各种任务中引人注目的序列建模和转换模型的组成部分，它允许对依赖关系进行建模，而不考虑它们在输入或输出序列中的距离 [2,19]。然而，除少数情况外 [27]，这种注意力机制都是与循环网络结合使用的。

在这项工作中，我们提出了 Transformer 模型架构，它避免使用循环，而是完全依赖注意力机制来提取输入和输出之间的全局依赖关系。Transformer 允许更多的并行化，并且在 8 个 P100 GPU 上训练仅 12 小时后，就可以在翻译质量方面达到新的最先进水平。

### 2 Background

The goal of reducing sequential computation also forms the foundation of the Extended Neural GPU [16], ByteNet [18] and ConvS2S [9], all of which use convolutional neural networks as basic building block, computing hidden representations in parallel for all input and output positions. In these models, the number of operations required to relate signals from two arbitrary input or output positions grows in the distance between positions, linearly for ConvS2S and logarithmically for ByteNet. This makes it more difficult to learn dependencies between distant positions [12]. In the Transformer this is reduced to a constant number of operations, albeit at the cost of reduced effective resolution due to averaging attention-weighted positions, an effect we counteract with Multi-Head Attention as described in section 3.2.

Self-attention, sometimes called intra-attention is an attention mechanism relating different positions of a single sequence in order to compute a representation of the sequence. Self-attention has been used successfully in a variety of tasks including reading comprehension, abstractive summarization, textual entailment and learning task-independent sentence representations [4, 27, 28, 22].

End-to-end memory networks are based on a recurrent attention mechanism instead of sequence-aligned recurrence and have been shown to perform well on simple-language question answering and language modeling tasks [34].

To the best of our knowledge, however, the Transformer is the first transduction model relying entirely on self-attention to compute representations of its input and output without using sequence-aligned RNNs or convolution. In the following sections, we will describe the Transformer, motivate self-attention and discuss its advantages over models such as [17, 18] and [9].

减少顺序计算的目标也构成了扩展神经 GPU（Extended Neural GPU）[16]、ByteNet [18] 和 ConvS2S [9] 的基础，它们都使用卷积神经网络（Convolutional Neural Networks）作为基本构建块，并行计算所有输入和输出位置的隐藏表示。在这些模型中，将两个任意输入或输出位置的信号关联起来所需的操作数量随着位置之间的距离而增长，对于 ConvS2S 是线性增长，对于 ByteNet 是对数增长。这使得学习远距离位置之间的依赖关系变得更加困难 [12]。在 Transformer 中，这被简化为恒定数量的操作，尽管代价是由于对注意力加权位置取平均而降低了有效分辨率，我们通过第 3.2 节中描述的多头注意力（Multi-Head Attention）来抵消这种影响。

自注意力（Self-Attention），有时称为内部注意力机制，是一种将单个序列的不同位置关联起来以计算序列表示的注意力机制。自注意力已成功应用于各种任务，包括阅读理解、抽象摘要、文本蕴涵和学习与任务无关的句子表示 [4,27,28,22]。

端到端记忆网络（End-to-End Memory Networks）基于循环注意力机制，而不是序列对齐的循环，并且已经在简单语言问题回答和语言建模任务上表现出良好的性能 [34]。

然而，据我们所知，Transformer 是第一个完全依赖自注意力来计算其输入和输出表示的转换模型，而无需使用序列对齐的循环神经网络（RNN）或卷积。在接下来的章节中，我们将描述 Transformer，阐释使用自注意力机制的动机，并讨论其相对于 [17,18] 和 [9] 等模型的优势。

### 3 Model Architecture

Most competitive neural sequence transduction models have an encoder-decoder structure [5, 2, 35]. Here, the encoder maps an input sequence of symbol representations $(x_1, ..., x_n)$ to a sequence of continuous representations $z = (z_1, ..., z_n)$. Given $z$, the decoder then generates an output sequence $(y_1, ..., y_m)$ of symbols one element at a time. At each step the model is auto-regressive [10], consuming the previously generated symbols as additional input when generating the next.

Figure 1: The Transformer - model architecture.

The Transformer follows this overall architecture using stacked self-attention and point-wise, fully connected layers for both the encoder and decoder, shown in the left and right halves of Figure 1, respectively.

3 模型架构

大多数具有竞争力的神经序列转换模型都采用了编码器-解码器（Encoder-Decoder）结构 [5,2,35]。在这种结构中，编码器将输入的符号表示序列 $(x_1，...，x_n)$ 映射为一个连续表示序列 $z =（z_1，...，z_n)$。给定 $z$ 后，解码器再一次生成一个符号的输出序列 $(y_1，...，y_m)$。在每一步中，模型都是自回归的（Auto-regressive）[10]，即在生成下一个符号时，将之前生成的符号作为附加输入。

图 1：Transformer 模型架构

Transformer 遵循这一总体架构，分别为编码器和解码器使用了堆叠的自注意力（Self-Attention）机制和逐点全连接层，如图 1 的左右两半部分所示。

#### 3.1 Encoder and Decoder Stacks

**Encoder:** The encoder is composed of a stack of $N = 6$ identical layers. Each layer has two sub-layers. The first is a multi-head self-attention mechanism, and the second is a simple, position-wise fully connected feed-forward network. We employ a residual connection [11] around each of the two sub-layers, followed by layer normalization [1]. That is, the output of each sub-layer is $LayerNorm(x + Sublayer(x))$, where $Sublayer(x)$ is the function implemented by the sub-layer itself. To facilitate these residual connections, all sub-layers in the model, as well as the embedding layers, produce outputs of dimension $d_{model} = 512$.

**Decoder:** The decoder is also composed of a stack of $N = 6$ identical layers. In addition to the two sub-layers in each encoder layer, the decoder inserts a third sub-layer, which performs multi-head attention over the output of the encoder stack. Similar to the encoder, we employ residual connections around each of the sub-layers, followed by layer normalization. We also modify the self-attention sub-layer in the decoder stack to prevent positions from attending to subsequent positions. This masking, combined with fact that the output embeddings are offset by one position, ensures that the predictions for position $i$ can depend only on the known outputs at positions less than $i$.

3.1 编码器和解码器堆栈

**编码器:** 编码器由 $N=6$ 个完全相同的层堆叠而成。每一层包含两个子层：第一个子层是一个多头自注意力机制，第二个子层是一个简单的逐位置全连接前馈网络。我们在每个子层周围采用了残差连接（Residual Connection）[11]，然后进行层归一化（Layer Normalization）[1]。也就是说，每个子层的输出是 $LayerNorm（x + Sublayer（x))$，其中 $Sublayer（x)$ 是该子层自身实现的函数。为了方便使用残差连接，模型中的所有子层以及词嵌入层的输出维度都是 $d_{model} = 512$。

**解码器:** 解码器同样由 $N=6$ 个完全相同的层堆叠而成。除了编码器中的两个子层外，解码器还引入了第三个子层，用于对编码器堆栈的输出执行多头注意力。与编码器类似，我们在每个子层周围使用残差连接，然后进行层归一化。我们还修改了解码器堆栈中的自注意力子层，防止其关注后续位置的信息。这种掩蔽操作与输出词嵌入偏移一个位置的事实结合在一起，确保了位置 $i$ 的预测只能依赖于小于位置 $i$ 的已知输出。

#### 3.2 Attention

An attention function can be described as mapping a query and a set of key-value pairs to an output, where the query, keys, values, and output are all vectors. The output is computed as a weighted sum of the values, where the weight assigned to each value is computed by a compatibility function of the query with the corresponding key.

Figure 2: (left) Scaled Dot-Product Attention. (right) Multi-Head Attention consists of several attention layers running in parallel.

3.2 注意力（Attention）机制

注意力（Attention）函数可以被理解为一个映射过程：它将一个查询（query）和一组键值（key-value）对映射到一个输出。在这个过程中，查询、键、值和输出都是向量。输出的计算方式是值的加权和，而每个值的权重则是通过查询和相应键之间的相关性函数来确定的。

图 2：注意力机制的两种形式

(左）缩放点积注意力（Scaled Dot-Product Attention)：这是一种基本的注意力计算方法。

(右）多头注意力（Multi-Head Attention)：这种方法包含多个并行运行的注意力层，能够捕捉更丰富的信息。

3.2.1 Scaled Dot-Product Attention

We call our particular attention "Scaled Dot-Product Attention" (Figure 2). The input consists of queries and keys of dimension $d_k$, and values of dimension $d_v$. We compute the dot products of the query with all keys, divide each by $\sqrt{d_k}$, and apply a softmax function to obtain the weights on the values.

In practice, we compute the attention function on a set of queries simultaneously, packed together into a matrix $Q$. The keys and values are also packed together into matrices $K$ and $V$. We compute the matrix of outputs as:

$$
\text{Attention}(Q, K, V) = \text{softmax}\left(\frac{QK^T}{\sqrt{d_k}}\right)V
$$

The two most commonly used attention functions are additive attention [2], and dot-product (multiplicative) attention. Dot-product attention is identical to our algorithm, except for the scaling factor of $\frac{1}{\sqrt{d_k}}$. Additive attention computes the compatibility function using a feed-forward network with a single hidden layer. While the two are similar in theoretical complexity, dot-product attention is much faster and more space-efficient in practice, since it can be implemented using highly optimized matrix multiplication code.

While for small values of $d_k$ the two mechanisms perform similarly, additive attention outperforms dot product attention without scaling for larger values of $d_k$ [3]. We suspect that for large values of $d_k$, the dot products grow large in magnitude, pushing the softmax function into regions where it has extremely small gradients. To counteract this effect, we scale the dot products by $\frac{1}{\sqrt{d_k}}$.

3.2.1 缩放点积注意力（Scaled Dot-Product Attention)

我们提出了一种特殊的注意力机制，称为「缩放点积注意力（Scaled Dot-Product Attention)」（如图 2 所示）。这种机制的输入包括查询（queries）和键（keys)（它们的维度都是 $d_k$），以及值（values)（维度为 $d_v$）。计算过程如下：首先，我们计算查询与所有键的点积；然后，将每个点积结果除以 $\sqrt {d_k}$（这个缩放操作有助于梯度的稳定性）；最后，我们使用 softmax 函数（一种将数值转化为概率分布的函数）来得到值的权重。

在实际应用中，我们通常需要同时处理多个查询。为了提高效率，我们将这些查询打包成一个矩阵 $Q$。同样，我们也将键和值分别打包成矩阵 $K$ 和 $V$。这样，我们就可以用一个简洁的矩阵运算来表示整个注意力计算过程：

$$
\text{Attention}(Q, K, V) = \text{softmax}\left(\frac{QK^T}{\sqrt{d_k}}\right)V
$$

这个公式概括了缩放点积注意力的核心操作，它能够高效地处理大规模的输入数据。

两种最常用的注意力（attention）机制是加性注意力 [2] 和点积（dot-product）注意力（也称为乘性注意力）。点积注意力与我们的算法基本相同，只是多了一个缩放因子 $\frac{1}{\sqrt{d_k}}$。加性注意力则使用一个只有一层隐藏层的前馈神经网络来计算输入之间的相关性。虽然这两种方法在理论上的计算复杂度相似，但在实际应用中，点积注意力的速度更快，而且占用的内存空间更少。这是因为点积注意力可以利用已经高度优化的矩阵乘法代码来实现。

当 $d_k$ 值较小时，加性注意力（additive attention）和点积注意力（dot product attention）这两种机制的表现相似。然而，当 $d_k$ 值较大时，在没有缩放的情况下，加性注意力的性能会优于点积注意力 [3]。我们推测，这是因为当 $d_k$ 值较大时，点积的结果会变得非常大，导致 softmax 函数被推向梯度极小的区域。在这个区域中，softmax 函数对输入的微小变化几乎没有反应，这不利于模型的学习和优化。为了解决这个问题，我们引入了一个缩放因子 $\frac{1}{\sqrt{d_k}}$ 来调整点积的大小。

3.2.2 Multi-Head Attention

Instead of performing a single attention function with $d_{\text{model}}$-dimensional keys, values and queries, we found it beneficial to linearly project the queries, keys and values $h$ times with different, learned linear projections to $d_k$, $d_k$, and $d_v$ dimensions, respectively. On each of these projected versions of queries, keys and values we then perform the attention function in parallel, yielding $d_v$-dimensional

Multi-head attention allows the model to jointly attend to information from different representation subspaces at different positions. With a single attention head, averaging inhibits this.

$$
\text{MultiHead}(Q, K, V) = \text{Concat}(\text{head}_1, \ldots, \text{head}_h)W^O
$$

where $\text{head}_i = \text{Attention}(QW_i^Q, KW_i^K, VW_i^V)$

Where the projections are parameter matrices $W_i^Q \in \mathbb{R}^{d_{model} \times d_k}$, $W_i^K \in \mathbb{R}^{d_{model} \times d_k}$, $W_i^V \in \mathbb{R}^{d_{model} \times d_v}$ and $W^O \in \mathbb{R}^{hd_v \times d_{model}}$.

In this work we employ $h = 8$ parallel attention layers, or heads. For each of these we use $d_k = d_v = d_{model}/h = 64$. Due to the reduced dimension of each head, the total computational cost is similar to that of single-head attention with full dimensionality.

3.2.2 多头注意力（Multi-Head Attention)

与使用维度为 $d_{\text{model}}$ 的键（Key）、值（Value）和查询（Query）来执行单一的注意力函数不同，我们发现使用不同的、学习得到的线性映射将查询、键和值分别投影到 $d_k$、$d_k$ 和 $d_v$ 维度，重复 $h$ 次，能够带来好处。然后，我们在查询、键和值的每个投影版本上并行执行注意力函数，产生维度为 $d_v$ 的输出。

多头注意力允许模型在不同位置同时关注来自不同表示子空间的信息。而使用单个注意力头的话，这种效果会被平均化操作所抑制。

$$
\text{MultiHead}(Q, K, V) = \text{Concat}(\text{head}_1, \ldots, \text{head}_h)W^O
$$

其中，$\text{head}_i = \text{Attention}(QW_i^Q, KW_i^K, VW_i^V)$

其中，投影操作通过参数矩阵来实现，这些矩阵包括 $W_i^Q \in \mathbb {R}^{d_{model} \times d_k}$、$W_i^K \in \mathbb {R}^{d_{model} \times d_k}$、$W_i^V \in \mathbb {R}^{d_{model} \times d_v}$ 和 $W^O \in \mathbb {R}^{hd_v \times d_{model}}$。这些数学符号看起来可能有些复杂，但它们实际上描述了模型如何处理和转换数据。

在我们的研究中，我们使用了 8 个并行的注意力（attention）机制，也称为 8 个注意力头（heads）。每个注意力头的工作维度是 64（即 $d_k = d_v = d_{model}/h = 64$）。虽然每个头的维度减小了，但由于有 8 个头并行工作，总的计算复杂度与使用全维度的单个注意力机制相近。这种设计既保证了模型的性能，又提高了计算效率。

3.2.3 Applications of Attention in our Model

The Transformer uses multi-head attention in three different ways:

- In "encoder-decoder attention" layers, the queries come from the previous decoder layer, and the memory keys and values come from the output of the encoder. This allows every position in the decoder to attend over all positions in the input sequence. This mimics the typical encoder-decoder attention mechanisms in sequence-to-sequence models such as [38, 2, 9].
- The encoder contains self-attention layers. In a self-attention layer all of the keys, values and queries come from the same place, in this case, the output of the previous layer in the encoder. Each position in the encoder can attend to all positions in the previous layer of the encoder.
- Similarly, self-attention layers in the decoder allow each position in the decoder to attend to all positions in the decoder up to and including that position. We need to prevent leftward information flow in the decoder to preserve the auto-regressive property. We implement this inside of scaled dot-product attention by masking out (setting to $-\infty$) all values in the input of the softmax which correspond to illegal connections. See Figure 2.

3.2.3 注意力机制在我们模型中的应用

Transformer 模型在以下三个不同的场景中使用了多头注意力（multi-head attention）机制：

1、在「编码器-解码器注意力」（encoder-decoder attention）层中，查询（queries）来自前一个解码器层，而键（keys）和值（values）则来自编码器的输出。这种机制使得解码器中的每个位置都能够对输入序列的所有位置进行注意力计算。这种设计模仿了序列到序列模型中典型的编码器-解码器注意力机制，例如在 [38，2，9] 等研究中所描述的那样。

2、编码器包含自注意力（self-attention）层。在自注意力层中，所有的键、值和查询都来自同一个地方，在这种情况下，它们源自编码器中前一层的输出。这意味着编码器中的每个位置都能够对编码器前一层的所有位置进行注意力计算。这种机制使得模型能够捕捉输入序列中的长距离依赖关系。

3、与编码器类似，解码器中的自注意力层（self-attention layers）也允许每个位置关注到该位置及其之前的所有位置。然而，为了保持解码器的自回归（auto-regressive）特性，我们需要防止信息从右向左流动。我们通过在缩放点积注意力（scaled dot-product attention）机制中使用掩码技术来实现这一点。具体来说，我们将所有不合法连接对应的 softmax 输入值设置为负无穷（$-\infty$），effectively 屏蔽了这些连接。这个过程在图 2 中有所展示。

#### 3.3 Position-wise Feed-Forward Networks

In addition to attention sub-layers, each of the layers in our encoder and decoder contains a fully connected feed-forward network, which is applied to each position separately and identically. This consists of two linear transformations with a ReLU activation in between.

$$
\text{FFN}(x) = \max(0, xW_1 + b_1)W_2 + b_2
$$

While the linear transformations are the same across different positions, they use different parameters from layer to layer. Another way of describing this is as two convolutions with kernel size 1. The dimensionality of input and output is $d_{model} = 512$, and the inner-layer has dimensionality $d_{ff} = 2048$.

#### 3.4 Embeddings and Softmax

Similarly to other sequence transduction models, we use learned embeddings to convert the input tokens and output tokens to vectors of dimension $d_{model}$. We also use the usual learned linear transformation and softmax function to convert the decoder output to predicted next-token probabilities. In our model, we share the same weight matrix between the two embedding layers and the pre-softmax linear transformation, similar to [30]. In the embedding layers, we multiply those weights by $\sqrt{d_{model}}$.

Table 1: Maximum path lengths, per-layer complexity and minimum number of sequential operations for different layer types. $n$ is the sequence length, $d$ is the representation dimension, $k$ is the kernel size of convolutions and $r$ the size of the neighborhood in restricted self-attention.

#### 3.5 Positional Encoding

Since our model contains no recurrence and no convolution, in order for the model to make use of the order of the sequence, we must inject some information about the relative or absolute position of the tokens in the sequence. To this end, we add "positional encodings" to the input embeddings at the bottoms of the encoder and decoder stacks. The positional encodings have the same dimension $d_{model}$ as the embeddings, so that the two can be summed. There are many choices of positional encodings, learned and fixed [9].

In this work, we use sine and cosine functions of different frequencies:

$$
PE_{(pos, 2i)} = \sin(pos / 10000^{2i / d_{model}})
$$

$$
PE_{(pos, 2i+1)} = \cos(pos / 10000^{2i / d_{model}})
$$

where $pos$ is the position and $i$ is the dimension. That is, each dimension of the positional encoding corresponds to a sinusoid. The wavelengths form a geometric progression from $2\pi$ to $10000 \cdot 2\pi$. We chose this function because we hypothesized it would allow the model to easily learn to attend by relative positions, since for any fixed offset $k$, $PE_{(pos+k)}$ can be represented as a linear function of $PE_{pos}$.

We also experimented with using learned positional embeddings [9] instead, and found that the two versions produced nearly identical results (see Table 3 row (E)). We chose the sinusoidal version because it may allow the model to extrapolate to sequence lengths longer than the ones encountered during training.

### 04 Why Self-Attention

In this section we compare various aspects of self-attention layers to the recurrent and convolutional layers commonly used for mapping one variable-length sequence of symbol representations $(x_1, ..., x_n)$ to another sequence of equal length $(z_1, ..., z_n)$, with $z_i \in \mathbb{R}^d$, such as a hidden layer in a typical sequence transduction encoder or decoder. Motivating our use of self-attention we consider three desiderata.

One is the total computational complexity per layer. Another is the amount of computation that can be parallelized, as measured by the minimum number of sequential operations required.

The third is the path length between long-range dependencies in the network. Learning long-range dependencies is a key challenge in many sequence transduction tasks. One key factor affecting the ability to learn such dependencies is the length of the paths forward and backward signals have to traverse in the network. The shorter these paths between any combination of positions in the input and output sequences, the easier it is to learn long-range dependencies [12]. Hence we also compare the maximum path length between any two input and output positions in networks composed of the different layer types.

As noted in Table 1, a self-attention layer connects all positions with a constant number of sequentially executed operations, whereas a recurrent layer requires $O(n)$ sequential operations. In terms of computational complexity, self-attention layers are faster than recurrent layers when the sequence

04 为什么选择自注意力机制

本节我们将比较自注意力（self-attention）层与常用的循环层和卷积层在各方面的异同。这些层的主要功能是将一个可变长度的符号表示序列 $(x_1, ..., x_n)$ 映射到另一个等长的序列 $(z_1, ..., z_n)$，其中 $z_i \in \mathbb {R}^d$。这种映射在典型的序列转换（sequence transduction）模型的编码器或解码器的隐藏层中经常出现。为了论证我们选择使用自注意力机制的原因，我们着重考虑了三个关键因素。

首先，我们关注每一层的总计算复杂度。其次，我们考虑可并行化的计算量，这通过所需的最少顺序操作次数来衡量。

第三个衡量标准是网络中长距离依赖关系之间的路径长度。在许多序列转换任务中，学习长距离依赖关系是一个关键挑战。影响学习这种依赖关系能力的一个重要因素是信息在网络中前向传播和反向传播时需要经过的路径长度。输入和输出序列中任意两个位置之间的路径越短，就越容易学习长距离依赖关系 [12]。因此，我们还比较了由不同类型层组成的网络中，任意两个输入和输出位置之间的最大路径长度。

如表 1 所示，自注意力层（self-attention layer）只需要固定数量的顺序操作就可以连接所有位置，而循环层（recurrent layer）则需要 $O（n)$ 个顺序操作（其中 n 表示序列长度）。从计算复杂度来看，当序列长度较短时，自注意力层的计算速度比循环层更快。



### 05 Training

This section describes the training regime for our models.

#### 5.1 Training Data and Batching

We trained on the standard WMT 2014 English-German dataset consisting of about 4.5 million sentence pairs. Sentences were encoded using byte-pair encoding [3], which has a shared source-target vocabulary of about 37000 tokens. For English-French, we used the significantly larger WMT 2014 English-French dataset consisting of 36M sentences and split tokens into a 32000 word-piece vocabulary [38]. Sentence pairs were batched together by approximate sequence length. Each training batch contained a set of sentence pairs containing approximately 25000 source tokens and 25000 target tokens.

#### 5.2 Hardware and Schedule

We trained our models on one machine with 8 NVIDIA P100 GPUs. For our base models using the hyperparameters described throughout the paper, each training step took about 0.4 seconds. We trained the base models for a total of 100,000 steps or 12 hours. For our big models (described on the bottom line of table 3), step time was 1.0 seconds. The big models were trained for 300,000 steps (3.5 days).

#### 5.3 Optimizer

We used the Adam optimizer [20] with $\beta_1 = 0.9$, $\beta_2 = 0.98$ and $\epsilon = 10^{-9}$. We varied the learning rate over the course of training, according to the formula:

$$
lrate = d_{model}^{-0.5} \cdot \min(step\_num^{-0.5}, step\_num \cdot warmup\_steps^{-1.5})
$$

This corresponds to increasing the learning rate linearly for the first $warmup\_steps$ training steps, and decreasing it thereafter proportionally to the inverse square root of the step number. We used $warmup\_steps = 4000$.

#### 5.4 Regularization

We employ three types of regularization during training:

Table 2: The Transformer achieves better BLEU scores than previous state-of-the-art models on the English-to-German and English-to-French newstest2014 tests at a fraction of the training cost.

**Residual Dropout** We apply dropout [33] to the output of each sub-layer, before it is added to the sub-layer input and normalized. In addition, we apply dropout to the sums of the embeddings and the positional encodings in both the encoder and decoder stacks. For the base model, we use a rate of $P_{drop} = 0.1$.

**Label Smoothing** During training, we employed label smoothing of value $\epsilon_{ls} = 0.1$ [36]. This hurts perplexity, as the model learns to be more unsure, but improves accuracy and BLEU score.




5 训练本节将介绍我们模型的训练方案。

5.1 训练数据和批处理

我们使用标准的 WMT 2014 英德翻译数据集进行模型训练，该数据集包含约 450 万对句子。所有句子都使用字节对编码（byte-pair encoding）[3] 进行编码，源语言和目标语言共享一个约 37000 个词元（token）的词汇表。对于英法翻译任务，我们使用了规模显著更大的 WMT 2014 英法数据集，其中包含 3600 万个句子，并将词元分割成 32000 个词片（word-piece）词汇表 [38]。在训练时，我们将长度相近的句子对组合成批次，每个训练批次包含一组句子对，大约含有 25000 个源语言词元和 25000 个目标语言词元。

5.2 硬件配置和训练时间我们在一台配备 8 个 NVIDIA P100 GPU 的机器上训练模型。对于使用本文描述的超参数的基础模型，每个训练步骤大约需要 0.4 秒。我们总共训练基础模型 100,000 步，约合 12 小时。而对于更大规模的模型（在表 3 的最后一行描述），每步训练时间增加到 1.0 秒，总共训练了 300,000 步，耗时 3.5 天。

5.3 优化器

我们使用 Adam 优化器（Adam optimizer）[20]，其中参数设置为 $\beta_1 = 0.9$，$\beta_2 = 0.98$ 和 $\epsilon = 10^{-9}$。在训练过程中，我们根据以下公式动态调整学习率：

$$
lrate = d_{model}^{-0.5} \cdot \min（step\_num^{-0.5}, step\_num \cdot warmup\_steps^{-1.5})
$$

这个公式的含义是：在训练的前 $warmup\_steps$ 步骤中，学习率呈线性增长；之后，学习率会按照步数的反平方根比例逐渐降低。在我们的实验中，$warmup\_steps$ 被设置为 4000。

5.4 正则化（Regularization)

在训练过程中，我们采用了三种正则化技术：

表 2：Transformer 模型在英语到德语和英语到法语的 newstest2014 测试中，以显著降低的训练成本获得了优于先前最先进模型的 BLEU（Bilingual Evaluation Understudy）分数。

**残差 Dropout** 我们在每个子层的输出上应用 dropout [33]，然后再将其与子层输入相加并进行归一化。此外，在编码器和解码器堆栈中，我们还对嵌入和位置编码的和应用 dropout。对于基础模型，我们使用的 dropout 率为 $P_{drop} = 0.1$。

**标签平滑化（Label Smoothing)** 在训练过程中，我们采用了一种叫做 "标签平滑化" 的技术，其参数值 $\epsilon_{ls}$ 设为 0.1 [36]。这种技术虽然会降低模型的困惑度（perplexity，一种评估语言模型预测能力的指标)，因为它使模型学会对预测结果保持一定程度的不确定性，但却能提高模型的准确率和 BLEU 分数（一种评估机器翻译质量的指标)。这种看似矛盾的结果实际上反映了模型在泛化能力和具体任务表现之间的平衡。标签平滑化技术通过引入一些不确定性，帮助模型避免过度自信，从而在实际应用中取得更好的表现。






### 06 Results

#### 6.1 Machine Translation

On the WMT 2014 English-to-German translation task, the big transformer model (Transformer (big) in Table 2) outperforms the best previously reported models (including ensembles) by more than 2.0 BLEU, establishing a new state-of-the-art BLEU score of 28.4. The configuration of this model is listed in the bottom line of Table 3. Training took 3.5 days on 8 P100 GPUs. Even our base model surpasses all previously published models and ensembles, at a fraction of the training cost of any of the competitive models.

On the WMT 2014 English-to-French translation task, our big model achieves a BLEU score of 41.0, outperforming all of the previously published single models, at less than 1/4 the training cost of the previous state-of-the-art model. The Transformer (big) model trained for English-to-French used dropout rate $P_{drop} = 0.1$, instead of 0.3.

For the base models, we used a single model obtained by averaging the last 5 checkpoints, which were written at 10-minute intervals. For the big models, we averaged the last 20 checkpoints. We used beam search with a beam size of 4 and length penalty $\alpha = 0.6$ [38]. These hyperparameters were chosen after experimentation on the development set. We set the maximum output length during inference to input length + 50, but terminate early when possible [38].

Table 2 summarizes our results and compares our translation quality and training costs to other model architectures from the literature. We estimate the number of floating point operations used to train a model by multiplying the training time, the number of GPUs used, and an estimate of the sustained single-precision floating-point capacity of each GPU.

#### 6.2 Model Variations

To evaluate the importance of different components of the Transformer, we varied our base model in different ways, measuring the change in performance on English-to-German translation on the

---

^5 We used values of 2.8, 3.7, 6.0 and 9.5 TFLOPS for K80, K40, M40 and P100, respectively.

Table 3: Variations on the Transformer architecture. Unlisted values are identical to those of the base model. All metrics are on the English-to-German translation development set, newstest2013. Listed perplexities are per-wordpiece, according to our byte-pair encoding, and should not be compared to per-word perplexities.

development set, newstest2013. We used beam search as described in the previous section, but no checkpoint averaging. We present these results in Table 3.

In Table 3 rows (A), we vary the number of attention heads and the attention key and value dimensions, keeping the amount of computation constant, as described in Section 3.2.2. While single-head attention is 0.9 BLEU worse than the best setting, quality also drops off with too many heads.

In Table 3 rows (B), we observe that reducing the attention key size $d_k$ hurts model quality. This suggests that determining compatibility is not easy and that a more sophisticated compatibility function than dot product may be beneficial. We further observe in rows (C) and (D) that, as expected, bigger models are better, and dropout is very helpful in avoiding over-fitting. In row (E) we replace our sinusoidal positional encoding with learned positional embeddings [9], and observe nearly identical results to the base model.

#### 6.3 English Constituency Parsing

To evaluate if the Transformer can generalize to other tasks we performed experiments on English constituency parsing. This task presents specific challenges: the output is subject to strong structural constraints and is significantly longer than the input. Furthermore, RNN sequence-to-sequence models have not been able to attain state-of-the-art results in small-data regimes [37].

We trained a 4-layer transformer with $d_{model} = 1024$ on the Wall Street Journal (WSJ) portion of the Penn Treebank [25], about 40K training sentences. We also trained it in a semi-supervised setting, using the larger high-confidence and BerkleyParser corpora from with approximately 17M sentences [37]. We used a vocabulary of 16K tokens for the WSJ only setting and a vocabulary of 32K tokens for the semi-supervised setting.

We performed only a small number of experiments to select the dropout, both attention and residual (section 5.4), learning rates and beam size on the Section 22 development set, all other parameters remained unchanged from the English-to-German base translation model. During inference, we

Table 4: The Transformer generalizes well to English constituency parsing (Results are on Section 23 of WSJ)

increased the maximum output length to input length + 300. We used a beam size of 21 and $\alpha = 0.3$ for both WSJ only and the semi-supervised setting.

Our results in Table 4 show that despite the lack of task-specific tuning our model performs surprisingly well, yielding better results than all previously reported models with the exception of the Recurrent Neural Network Grammar [8].

In contrast to RNN sequence-to-sequence models [37], the Transformer outperforms the Berkeley-Parser [29] even when training only on the WSJ training set of 40K sentences.

### 7 Conclusion

In this work, we presented the Transformer, the first sequence transduction model based entirely on attention, replacing the recurrent layers most commonly used in encoder-decoder architectures with multi-headed self-attention.

For translation tasks, the Transformer can be trained significantly faster than architectures based on recurrent or convolutional layers. On both WMT 2014 English-to-German and WMT 2014 English-to-French translation tasks, we achieve a new state of the art. In the former task our best model outperforms even all previously reported ensembles.

We are excited about the future of attention-based models and plan to apply them to other tasks. We plan to extend the Transformer to problems involving input and output modalities other than text and to investigate local, restricted attention mechanisms to efficiently handle large inputs and outputs such as images, audio and video. Making generation less sequential is another research goals of ours.

The code we used to train and evaluate our models is available at [https://github.com/tensorflow/tensor2tensor](https://github.com/tensorflow/tensor2tensor).

### Acknowledgements

We are grateful to Nal Kalchbrenner and Stephan Gouws for their fruitful comments, corrections and inspiration.

### References

[1] Jimmy Lei Ba, Jamie Ryan Kiros, and Geoffrey E Hinton. Layer normalization. *arXiv preprint arXiv:1607.06450*, 2016.

[2] Dzmitry Bahdanau, Kyunghyun Cho, and Yoshua Bengio. Neural machine translation by jointly learning to align and translate. *CoRR, abs/1409.0473*, 2014.

[3] Denny Britz, Anna Goldie, Minh-Thang Luong, and Quoc V Le. Massive exploration of neural machine translation architectures. *CoRR, abs/1703.03906*, 2017.

[4] Jianpeng Cheng, Li Dong, and Mirella Lapata. Long short-term memory-networks for machine reading. *arXiv preprint arXiv:1601.06733*, 2016.

[5] Kyunghyun Cho, Bart van Merriënboer, Caglar Gulcehre, Fethi Bougares, Holger Schwenk, and Yoshua Bengio. Learning phrase representations using rnn encoder-decoder for statistical machine translation. CoRR, abs/1406.1078, 2014.

[6] Francois Chollet. Xception: Deep learning with depthwise separable convolutions. arXiv preprint arXiv:1610.02357, 2016.

[7] Junyoung Chung, Caglar Gulcehre, Kyunghyun Cho, and Yoshua Bengio. Empirical evaluation of gated recurrent neural networks on sequence modeling. CoRR, abs/1412.3555, 2014.

[8] Chris Dyer, Adhiguna Kuncoro, Miguel Ballesteros, and Noah A. Smith. Recurrent neural network grammars. In Proc. of NAACL, 2016.

[9] Jonas Gehring, Michael Auli, David Grangier, Denis Yarats, and Yann N. Dauphin. Convolutional sequence to sequence learning. arXiv preprint arXiv:1705.03122v2, 2017.

[10] Alex Graves. Generating sequences with recurrent neural networks. arXiv preprint arXiv:1308.0850, 2013.

[11] Kaiming He, Xiangyu Zhang, Shaoqing Ren, and Jian Sun. Deep residual learning for image recognition. In Proceedings of the IEEE Conference on Computer Vision and Pattern Recognition, pages 770–778, 2016.

[12] Sepp Hochreiter, Yoshua Bengio, Paolo Frasconi, and Jürgen Schmidhuber. Gradient flow in recurrent nets: the difficulty of learning long-term dependencies, 2001.

[13] Sepp Hochreiter and Jürgen Schmidhuber. Long short-term memory. Neural computation, 9(8):1735–1780, 1997.

[14] Zhongqiang Huang and Mary Harper. Self-training PCFG grammars with latent annotations across languages. In Proceedings of the 2009 Conference on Empirical Methods in Natural Language Processing, pages 832–841. ACL, August 2009.

[15] Rafal Jozefowicz, Oriol Vinyals, Mike Schuster, Noam Shazeer, and Yonghui Wu. Exploring the limits of language modeling. arXiv preprint arXiv:1602.02410, 2016.

[16] Łukasz Kaiser and Samy Bengio. Can active memory replace attention? In Advances in Neural Information Processing Systems, (NIPS), 2016.

[17] Łukasz Kaiser and Ilya Sutskever. Neural GPUs learn algorithms. In International Conference on Learning Representations (ICLR), 2016.

[18] Nal Kalchbrenner, Lasse Espeholt, Karen Simonyan, Aaron van den Oord, Alex Graves, and Koray Kavukcuoglu. Neural machine translation in linear time. arXiv preprint arXiv:1610.10099v2, 2017.

[19] Yoon Kim, Carl Denton, Luong Hoang, and Alexander M. Rush. Structured attention networks. In International Conference on Learning Representations, 2017.

[20] Diederik Kingma and Jimmy Ba. Adam: A method for stochastic optimization. In ICLR, 2015.

[21] Oleksii Kuchaiev and Boris Ginsburg. Factorization tricks for LSTM networks. arXiv preprint arXiv:1703.10722, 2017.

[22] Zhouhan Lin, Minwei Feng, Cicero Nogueira dos Santos, Mo Yu, Bing Xiang, Bowen Zhou, and Yoshua Bengio. A structured self-attentive sentence embedding. arXiv preprint arXiv:1703.03130, 2017.

[23] Minh-Thang Luong, Quoc V. Le, Ilya Sutskever, Oriol Vinyals, and Lukasz Kaiser. Multi-task sequence to sequence learning. arXiv preprint arXiv:1511.06114, 2015.

[24] Minh-Thang Luong, Hieu Pham, and Christopher D Manning. Effective approaches to attention-based neural machine translation. arXiv preprint arXiv:1508.04025, 2015.

[25] Mitchell P Marcus, Mary Ann Marcinkiewicz, and Beatrice Santorini. Building a large annotated corpus of english: The penn treebank. *Computational linguistics*, 19(2):313–330, 1993.

[26] David McClosky, Eugene Charniak, and Mark Johnson. Effective self-training for parsing. In *Proceedings of the Human Language Technology Conference of the NAACL, Main Conference*, pages 152–159. ACL, June 2006.

[27] Ankur Parikh, Oscar Täckström, Dipanjan Das, and Jakob Uszkoreit. A decomposable attention model. In *Empirical Methods in Natural Language Processing*, 2016.

[28] Romain Paulus, Caiming Xiong, and Richard Socher. A deep reinforced model for abstractive summarization. *arXiv preprint arXiv:1705.04304*, 2017.

[29] Slav Petrov, Leon Barrett, Romain Thibaux, and Dan Klein. Learning accurate, compact, and interpretable tree annotation. In *Proceedings of the 21st International Conference on Computational Linguistics and 44th Annual Meeting of the ACL*, pages 433–440. ACL, July 2006.

[30] Ofir Press and Lior Wolf. Using the output embedding to improve language models. *arXiv preprint arXiv:1608.05859*, 2016.

[31] Rico Sennrich, Barry Haddow, and Alexandra Birch. Neural machine translation of rare words with subword units. *arXiv preprint arXiv:1508.07909*, 2015.

[32] Noam Shazeer, Azalia Mirhoseini, Krzysztof Maziarz, Andy Davis, Quoc Le, Geoffrey Hinton, and Jeff Dean. Outrageously large neural networks: The sparsely-gated mixture-of-experts layer. *arXiv preprint arXiv:1701.06538*, 2017.

[33] Nitish Srivastava, Geoffrey E Hinton, Alex Krizhevsky, Ilya Sutskever, and Ruslan Salakhutdinov. Dropout: a simple way to prevent neural networks from overfitting. *Journal of Machine Learning Research*, 15(1):1929–1958, 2014.

[34] Sainbayar Sukhbaatar, Arthur Szlam, Jason Weston, and Rob Fergus. End-to-end memory networks. In C. Cortes, N. D. Lawrence, D. D. Lee, M. Sugiyama, and R. Garnett, editors, *Advances in Neural Information Processing Systems 28*, pages 2440–2448. Curran Associates, Inc., 2015.

[35] Ilya Sutskever, Oriol Vinyals, and Quoc VV Le. Sequence to sequence learning with neural networks. In *Advances in Neural Information Processing Systems*, pages 3104–3112, 2014.

[36] Christian Szegedy, Vincent Vanhoucke, Sergey Ioffe, Jonathon Shlens, and Zbigniew Wojna. Rethinking the inception architecture for computer vision. *CoRR*, abs/1512.00567, 2015.

[37] Vinyals & Kaiser, Koo, Petrov, Sutskever, and Hinton. Grammar as a foreign language. In *Advances in Neural Information Processing Systems*, 2015.

[38] Yonghui Wu, Mike Schuster, Zhifeng Chen, Quoc V Le, Mohammad Norouzi, Wolfgang Macherey, Maxim Krikun, Yuan Cao, Qin Gao, Klaus Macherey, et al. Google’s neural machine translation system: Bridging the gap between human and machine translation. *arXiv preprint arXiv:1609.08144*, 2016.

[39] Jie Zhou, Ying Cao, Xuguang Wang, Peng Li, and Wei Xu. Deep recurrent models with fast-forward connections for neural machine translation. *CoRR*, abs/1606.04199, 2016.

[40] Muhua Zhu, Yue Zhang, Wenliang Chen, Min Zhang, and Jingbo Zhu. Fast and accurate shift-reduce constituent parsing. In *Proceedings of the 51st Annual Meeting of the ACL (Volume 1: Long Papers)*, pages 434–443. ACL, August 2013.

Figure 3: An example of the attention mechanism following long-distance dependencies in the encoder self-attention in layer 5 of 6. Many of the attention heads attend to a distant dependency of the verb ‘making’, completing the phrase ‘making...more difficult’. Attentions here shown only for the word ‘making’. Different colors represent different heads. Best viewed in color.