## 2024037Generating-Sequences-With-Recurrent-Neural-Networks

Generating Sequences With  
Recurrent Neural Networks  
Alex Graves  
Department of Computer Science  
University of Toronto  
graves@cs.toronto.edu  

### Abstract

This paper shows how Long Short-term Memory recurrent neural networks can be used to generate complex sequences with long-range structure, simply by predicting one data point at a time. The approach is demonstrated for text (where the data are discrete) and online handwriting (where the data are real-valued). It is then extended to handwriting synthesis by allowing the network to condition its predictions on a text sequence. The resulting system is able to generate highly realistic cursive handwriting in a wide variety of styles.

摘要

本文展示了如何使用长短期记忆（Long Short-term Memory, LSTM）循环神经网络生成具有长程结构的复杂序列，仅通过每次预测一个数据点即可实现。该方法在文本（离散数据）和实时手写（连续值数据）两个领域进行了演示。随后，通过允许网络基于文本序列调节其预测，将该方法扩展到手写文本合成。由此开发的系统能够以多种风格生成高度逼真的手写文本。

### 1 Introduction

Recurrent neural networks (RNNs) are a rich class of dynamic models that have been used to generate sequences in domains as diverse as music, text, and motion capture data. RNNs can be trained for sequence generation by processing real data sequences one step at a time and predicting what comes next. Assuming the predictions are probabilistic, novel sequences can be generated from a trained network by iteratively sampling from the network's output distribution, then feeding in the sample as input at the next step. In other words by making the network treat its inventions as if they were real, much like a person dreaming. Although the network itself is deterministic, the stochasticity injected by picking samples induces a distribution over sequences. This distribution is conditional, since the internal state of the network, and hence its predictive distribution, depends on the previous inputs.

RNNs are ‘fuzzy’ in the sense that they do not use exact templates from the training data to make predictions, but rather—like other neural networks—use their internal representation to perform a high-dimensional interpolation between training examples. This distinguishes them from n-gram models and compression algorithms such as Prediction by Partial Matching, whose predictive distributions are determined by counting exact matches between the recent history and the training set. The result—which is immediately apparent from the samples in this paper—is that RNNs (unlike template-based algorithms) synthesise and reconstitute the training data in a complex way, and rarely generate the same thing twice. Furthermore, fuzzy predictions do not suffer from the curse of dimensionality, and are therefore much better at modelling real-valued or multivariate data than exact matches.

In principle a large enough RNN should be sufficient to generate sequences of arbitrary complexity. In practice however, standard RNNs are unable to store information about past inputs for very long. As well as diminishing their ability to model long-range structure, this ‘amnesia’ makes them prone to instability when generating sequences. The problem (common to all conditional generative models) is that if the network’s predictions are only based on the last few inputs, and these inputs were themselves predicted by the network, it has little opportunity to recover from past mistakes. Having a longer memory has a stabilising effect, because even if the network cannot make sense of its recent history, it can look further back in the past to formulate its predictions. The problem of instability is especially acute with real-valued data, where it is easy for the predictions to stray from the manifold on which the training data lies. One remedy that has been proposed for conditional models is to inject noise into the predictions before feeding them back into the model, thereby increasing the model’s robustness to surprising inputs. However we believe that a better memory is a more profound and effective solution.

Long Short-term Memory (LSTM) is an RNN architecture designed to be better at storing and accessing information than standard RNNs. LSTM has recently given state-of-the-art results in a variety of sequence processing tasks, including speech and handwriting recognition. The main goal of this paper is to demonstrate that LSTM can use its memory to generate complex, realistic sequences containing long-range structure.

Section 2 defines a ‘deep’ RNN composed of stacked LSTM layers, and explains how it can be trained for next-step prediction and hence sequence generation. Section 3 applies the prediction network to text from the Penn Treebank and Hutter Prize Wikipedia datasets. The network’s performance is competitive with state-of-the-art language models, and it works almost as well when predicting one character at a time as when predicting one word at a time. The highlight of the section is a generated sample of Wikipedia text, which showcases the network’s ability to model long-range dependencies. Section 4 demonstrates how the prediction network can be applied to real-valued data through the use of a mixture density output layer, and provides experimental results on the IAM Online Handwriting Database. It also presents generated handwriting samples proving the network’s ability to learn letters and short words direct from pen traces, and to model global features of handwriting style. Section 5 introduces an extension to the prediction network that allows it to condition its outputs on a short annotation sequence whose alignment with the predictions is unknown. This makes it suitable for handwriting synthesis, where a human user inputs a text and the algorithm generates a handwritten version of it. The synthesis network is trained on the IAM database, then used to generate cursive handwriting samples, some of which cannot be distinguished from real data by the naked eye. A method for biasing the samples towards higher probability (and
greater legibility) is described, along with a technique for ‘priming’ the samples on real data and thereby mimicking a particular writer’s style. Finally, concluding remarks and directions for future work are given in Section 6.

Figure 1: Deep recurrent neural network prediction architecture. The circles represent network layers, the solid lines represent weighted connections and the dashed lines represent predictions.

1 引言

循环神经网络（Recurrent Neural Networks，RNNs）是一类功能强大的动态模型，已被应用于音乐、文本和动作捕捉等多个领域的序列生成任务。RNNs 可以通过逐步处理真实数据序列并预测下一步内容来训练序列生成能力。假设这些预测是概率性的，那么我们可以通过不断从网络的输出分布中采样，并将样本作为下一步的输入，从而利用训练好的网络生成新的序列。换句话说，这个过程就像是让网络将自己的创造视为现实，类似于人类做梦的过程。尽管网络本身是确定性的，但通过采样引入的随机性会产生一个序列分布。这个分布是条件性的，因为网络的内部状态及其预测分布取决于先前的输入。

循环神经网络（Recurrent Neural Networks，RNNs）的工作方式可以说是「模糊的」。这里的「模糊」指的是，RNNs 不像某些传统算法那样直接使用训练数据中的精确模板来进行预测。相反，RNNs 与其他神经网络类似，利用其内部表示在高维空间中对训练样本进行插值。这种方法使得 RNNs 能够在训练样本之间进行复杂的推断和预测。

这一特性将 RNNs 与 n-gram 模型（一种基于统计的语言模型）和某些压缩算法（如部分匹配预测，Prediction by Partial Matching）区分开来。后者的预测分布主要依赖于计算最近历史与训练集之间的精确匹配次数。

RNNs 的这种「模糊」特性带来了显著的效果，这一点从本文的样本中可以直观地看出。与基于模板的算法不同，RNNs 能够以复杂的方式合成和重构训练数据，几乎每次都能生成独特的内容。这意味着 RNNs 很少会重复生成完全相同的内容。

此外，这种模糊预测方法还有一个重要优势：它不受所谓「维度灾难」（curse of dimensionality，指在高维空间中数据变得稀疏，导致分析困难的现象）的影响。因此，在处理实值数据或多变量数据时，模糊预测方法比精确匹配方法表现得更为出色。

原则上，一个足够大的循环神经网络（RNN，Recurrent Neural Network）应该能够生成任何复杂程度的序列。然而，实际情况却不尽如人意。标准的 RNN 模型往往无法长时间记住过去的输入信息。这种「健忘」特性不仅削弱了它们理解和生成长序列的能力，还导致了在生成序列时容易出现不稳定的情况。

这个问题其实是所有条件生成模型都面临的共同挑战。如果网络的预测仅仅基于最近的几个输入，而这些输入又是网络自己预测出来的，那么一旦出现错误，网络就很难自我纠正。相比之下，如果网络能够「记住」更长时间的信息，即使它无法理解最近的历史，也可以回顾更早的信息来做出预测，从而起到稳定作用。

这种不稳定性在处理实值数据时尤为明显。因为在这种情况下，预测结果很容易偏离训练数据所在的数学空间（称为「流形」）。为了解决这个问题，一些研究者提出在将预测结果反馈给模型之前，先向其中加入一些随机噪声。这样做可以增强模型对意外输入的适应能力（也称为「鲁棒性」）。

然而，我们认为，与其采取这种治标不治本的方法，不如从根本上提高模型的记忆能力。这种方法不仅更加深刻，也更加有效。

长短期记忆（Long Short-term Memory，LSTM）是一种循环神经网络（Recurrent Neural Network，RNN）架构，它的设计目的是为了比标准的 RNN 更好地存储和访问信息。最近，LSTM 在多种序列处理任务中都取得了领先的成果，包括语音识别和手写识别。这篇论文的主要目标是要证明 LSTM 能够利用其记忆机制来生成复杂且逼真的序列，这些序列具有长距离依赖的结构特征（即序列中相距较远的元素之间存在关联）。

第 2 节定义了一个由多层堆叠 LSTM（Long Short-Term Memory）组成的「深层」循环神经网络（RNN），并解释了如何训练它进行序列中下一个元素的预测，从而实现序列生成。

第 3 节将这个预测网络应用于来自 Penn Treebank（一个经典的自然语言处理数据集）和 Hutter Prize 维基百科数据集（一个用于评估数据压缩算法的大规模文本数据集）的文本。该网络的性能与最先进的语言模型相当，而且无论是一次预测一个字符还是一次预测一个单词，其效果都几乎一样好。本节的亮点是展示了一段由网络生成的维基百科文本样本，充分展现了该网络模拟长距离依赖关系的能力。

第 4 节演示了如何通过使用混合密度输出层（mixture density output layer）将预测网络应用于实值数据，并提供了在 IAM 在线手写数据库（一个包含真实手写文本的数字化数据集）上的实验结果。此外，还展示了由网络生成的手写样本，证明了该网络能够直接从笔迹中学习字母和短词，并模拟手写风格的整体特征。

第 5 节介绍了对预测网络的一项扩展，使其能够根据一个简短的注释序列来调节输出，即使这个注释序列与预测结果的对齐关系未知。这一特性使得该网络特别适用于手写文本合成，即人类用户输入文本，算法生成其手写版本。研究人员在 IAM 数据库上训练了这个合成网络，然后用它来生成连笔手写样本。其中一些生成的样本甚至达到了以假乱真的程度，肉眼无法与真实手写区分开来。文中还介绍了一种方法，可以使生成的样本偏向更高概率（因此更加真实）的结果，同时还介绍了一种在真实数据上对样本进行「启动」（priming）的技术，从而模仿特定作者的写作风格。最后，第 6 节给出了结论和未来研究方向。

图 1：深度循环神经网络（Deep recurrent neural network）预测架构。图中的圆圈表示网络层，实线表示带权重的连接，虚线则表示预测过程。

### 2 Prediction Network

Fig. 1 illustrates the basic recurrent neural network prediction architecture used in this paper. An input vector sequence $x = (x_1, \ldots, x_T)$ is passed through weighted connections to a stack of $N$ recurrently connected hidden layers to compute first the hidden vector sequences $h^n = (h^n_1, \ldots, h^n_T)$ and then the output vector sequence $y = (y_1, \ldots, y_T)$. Each output vector $y_t$ is used to parameterise a predictive distribution $Pr(x_{t+1}|y)$. The first element $x_1$ of every input sequence is always a null vector whose entries are all zero; the network therefore emits a prediction for $x_2$, the first real input, with no prior information. The network is ‘deep’ in both space and time, in the sense that every piece of information passing either vertically or horizontally through the computation graph will be acted on by multiple successive weight matrices and non-linearities.

Note the ‘skip connections’ from the inputs to all hidden layers, and from all hidden layers to the outputs. These make it easier to train deep networks, by reducing the number of processing steps between the bottom of the network and the top, and thereby mitigating the ‘vanishing gradient’ problem [1]. In the special case that $N = 1$ the architecture reduces to an ordinary, single layer next step prediction RNN.

The hidden layer activations are computed by iterating the following equations from $t = 1$ to $T$ and from $n = 2$ to $N$:

$$
h^1_t = \mathcal{H}(W_{i1}x_t + W_{h1}h_{t-1} - b_{h1}) \tag{1}
$$

$$
h^n_t = \mathcal{H}(W_{in}x_t + W_{n-1}h_{n-1} + W_{nh}h_{n-1} + v_{bn}) \tag{2}
$$

where the $W$ terms denote weight matrices (e.g., $W_{in}$ is the weight matrix connecting the inputs to the $n^{th}$ hidden layer, $W_{h1}$ is the recurrent connection at the first hidden layer, and so on), the $b$ terms denote bias vectors (e.g., $b_y$ is the output bias vector) and $\mathcal{H}$ is the hidden layer function.

Given the hidden sequences, the output sequence is computed as follows:

$$
\hat{y}_t = b_y + \sum_{n=1}^{N} W_{ny}h^n_t \tag{3}
$$

$$
y_t = \mathcal{Y}(\hat{y}_t) \tag{4}
$$

where $\mathcal{Y}$ is the output layer function. The complete network therefore defines a function, parameterised by the weight matrices, from input histories $x_{t-L}$ to output vectors $y_t$.

The output vectors $y_t$ are used to parameterise the predictive distribution $Pr(x_{t+1}|y_t)$ for the next input. The form of $Pr(x_{t+1}|y_t)$ must be chosen carefully to match the input data. In particular, finding a good predictive distribution for high-dimensional, real-valued data (usually referred to as density modelling) can be very challenging.

The probability given by the network to the input sequence $x$ is 

$$
Pr(x) = \prod_{t=1}^{T} Pr(x_{t+1}|y_t) \tag{5}
$$

and the sequence loss $\mathcal{L}(x)$ used to train the network is the negative logarithm of $Pr(x)$:

$$
\mathcal{L}(x) = - \sum_{t=1}^{T} \log Pr(x_{t+1}|y_t) \tag{6}
$$

The partial derivatives of the loss with respect to the network weights can be efficiently calculated with backpropagation through time [33] applied to the computation graph shown in Fig. 1, and the network can then be trained with gradient descent.

2.1 Long Short-Term Memory

In most RNNs the hidden layer function $\mathcal{H}$ is an elementwise application of a sigmoid function. However we have found that the Long Short-Term Memory (LSTM) architecture [16], which uses purpose-built memory cells to store information, is better at finding and exploiting long range dependencies in the data. Fig. 2 illustrates a simple LSTM memory cell. For the version of LSTM used in this paper [7] it's implemented by the following composite function:

$$
i_t = \sigma(W_{xi}x_t + W_{hi}h_{t-1} + W_{ci}c_{t-1} + b_i) \tag{7}
$$

$$
f_t = \sigma(W_{xf}x_t + W_{hf}h_{t-1} + W_{cf}c_{t-1} + b_f) \tag{8}
$$

$$
c_t = f_t \circ c_{t-1} + i_t \circ \tanh(W_{xc}x_t + W_{hc}h_{t-1} + b_c) \tag{9}
$$

$$
o_t = \sigma(W_{xo}x_t + W_{ho}h_{t-1} + W_{co}c_t + b_o) \tag{10}
$$

$$
h_t = o_t \circ \tanh(c_t) \tag{11}
$$

where $\sigma$ is the logistic sigmoid function, and $i$, $f$, $o$ and $c$ are respectively the input gate, forget gate, output gate, cell and cell input activation vectors, all of which are the same size as the hidden vector $h$. The weight matrix subscripts have the obvious meaning, for example $W_{hi}$ is the hidden-input gate matrix, $W_{xo}$ is the input-output gate matrix etc. The weight matrices from the cell gate vectors (e.g. $W_{ci}$) are diagonal, so element $m$ in each vector only receives input from element $m$ of the cell vector. The bias terms (which are added to $i$, $f$, $c$ and $h$) have been omitted for clarity.

The original LSTM algorithm used a custom designed approximate gradient calculation that allowed the weights to be updated after every timestep [16]. However the full gradient can instead be calculated with backpropagation through time [11], the method used in this paper. One difficulty when training LSTM with the full gradient is that the derivatives sometimes become excessively large.


leading to numerical problems. To prevent this, all the experiments in this paper clipped the derivative of the loss with respect to the network inputs to the LSTM layers (before the sigmoid and tanh functions are applied) to lie within a predefined range¹.

3 Text Prediction  
Text data is discrete, and is typically presented to neural networks using ‘one-hot’ input vectors. That is, if there are \(K\) text classes in total, and class \(k\) is fed in at time \(t\), then \(x_t\) is a length \(K\) vector whose entries are all zero except for the \(k\)th, which is one. \(Pr(x_t|y_{1:t})\) is therefore a multinomial distribution, which can be naturally parameterised by a softmax function at the output layer:  
$$  
Pr(x_t = k|y_t) = y_t^k = \frac{\exp(\hat{y}^k)}{\sum_{k' = 1}^K \exp(\hat{y}^{k'})}  
$$  

Substituting into Eq. (6) we see that  
$$  
L(x) = -\sum_{t=1}^T \log \pi_{x^{t+1}}  
$$  

$$  
\Rightarrow \frac{\partial L(x)}{\partial y_{t}^k} = \hat{y}^k - \delta_{k,x_{t+1}}  
$$  

The only thing that remains to be decided is which set of classes to use. In most cases, text prediction (usually referred to as language modelling) is performed at the word level. \(K\) is therefore the number of words in the dictionary. This can be problematic for realistic tasks, where the number of words (including variant conjugations, proper names, etc.) often exceeds 100,000, as well as requiring many parameters to model, having so many classes demands a huge amount of training data to adequately cover the possible contexts for the words. In the case of softmax models, a further difficulty is the high computational cost of evaluating all the exponentials during training (although several methods have been devised make training large softmax layers more efficient, including tree-based models, low rank approximations and stochastic derivatives [26]). Furthermore, word-level models are not applicable to text data containing non-word strings, such as multi-digit numbers or web addresses.

Character-level language modelling with neural networks has recently been considered [30, 24], and found to give slightly worse performance than equivalent word-level models. Nonetheless, predicting one character at a time is more interesting from the perspective of sequence generation, because it allows the network to invent novel words and strings. In general, the experiments in this paper aim to predict at the finest granularity found in the data, so as to maximise the generative flexibility of the network.  

¹In fact this technique was used in all my previous papers on LSTM, and in my publicly available LSTM code, but I forgot to mention it anywhere—mea culpa.


3.1 Penn Treebank Experiments

The first set of text prediction experiments focused on the Penn Treebank portion of the Wall Street Journal corpus [22]. This was a preliminary study whose main purpose was to gauge the predictive power of the network, rather than to generate interesting sequences.

Although a relatively small text corpus (a little over a million words in total), the Penn Treebank data is widely used as a language modelling benchmark. The training set contains 930,000 words, the validation set contains 74,000 words and the test set contains 82,000 words. The vocabulary is limited to 10,000 words, with all other words mapped to a special ‘unknown word’ token. The end-of-sentence token was included in the input sequences, and was counted in the sequence loss. The start-of-sentence marker was ignored, because its role is already fulfilled by the null vectors that begin the sequences (c.f. Section 2).

The experiments compared the performance of word and character-level LSTM predictors on the Penn corpus. In both cases, the network architecture was a single hidden layer with 100 LSTM units. For the character-level network the input and output layers were size 49, giving approximately 4.3M weights in total, while the word-level network had 10,000 inputs and outputs and around 54M weights. The comparison is therefore somewhat unfair, as the word-level network had many more parameters. However, as the dataset is small, both networks were easily able to overfit the training data, and it is not clear whether the character-level network would have benefited from more weights. All networks were trained with stochastic gradient descent, using a learn rate of 0.0001 and a momentum of 0.99. The LSTM derivates were clipped in the range [−1, 1], (c.f. Section 2.1).

Neural networks are usually evaluated on test data with fixed weights. For prediction problems however, where the inputs are the targets, it is legitimate to allow the network to adapt its weights as it is being evaluated (so long as it only sees the test data once). Mikolov refers to this as dynamic evaluation. Dynamic evaluation allows for a fairer comparison with compression algorithms, for which there is no division between training and test sets, as all data is only predicted once.

Since both networks overfit the training data, we also experimented with two types of regularisation: weight noise [18] with a std. deviation of 0.075 applied to the network weights at the start of each training sequence, and adaptive weight noise [8], where the variance of the noise is learned along with the weights using a Minimum description Length (or equivalently, variational inference) loss function. When weight noise was used, the network was initialised with the final weights of the unregularised network. Similarly, when adaptive weight noise was used, the weights were initialised with those of the network trained with weight noise. We have found that retraining with iteratively increased regularisation is considerably faster than training from random weights with regularisation. Adaptive weight noise was found to be prohibitively slow for the word-level network, so it was regularised with fixed-variance weight noise only. One advantage of adaptive weight is that early stopping is not needed.


|   #   |    SATION    |    DYNAMIC    |   BPC   | PERPLEXITY | ERROR (%) | EPOCHS |
|-------|--------------|---------------|---------|------------|-----------|--------|
| CHAR  |     NONE     |       NO      |  1.32   |    167     |   28.5    |   9    |
| CHAR  |     NONE     |       YES     |  1.29   |    148     |   28.0    |   9    |
| CHAR  | WEIGHT NOISE |       NO      |  1.27   |    140     |   27.4    |   25   |
| CHAR  | WEIGHT NOISE |      YES      |  1.24   |    124     |   26.9    |   25   |
| CHAR  | ADAPT. WT. NOISE |    YES    |  1.26   |    133     |   27.4    |   26   |
| WORD  |     NONE     |       NO      |  1.27   |    138     |   77.8    |   11   |
| WORD  |     NONE     |       YES     |  1.25   |    126     |   76.9    |   11   |
| WORD  | WEIGHT NOISE |       NO      |  1.25   |    126     |   76.9    |   14   |
| WORD  | WEIGHT NOISE |      YES      |  1.23   |    117     |   76.2    |   14   |

(The network can safely be stopped at the point of minimum total 'description length' on the training data). However, to keep the comparison fair, the same training, validation and test sets were used for all experiments.

The results are presented with two equivalent metrics: bits-per-character (BPC), which is the average value of $-log_2 Pr(x_{t+1}|y)$ over the whole test set; and perplexity which is two to the power of the average number of bits per word (the average word length on the test set is about 5.6 characters, so perplexity $\approx 2^{.5BPC}$). Perplexity is the usual performance measure for language modeling.

Table 1 shows that the word-level RNN performed better than the character-level network, but the gap appeared to close when regularization is used. Overall the results compare favourably with those collected in Tomas Mikolov's thesis. For example, he records a perplexity of 141 for a 5-gram with Kneser-Ney smoothing, 141.8 for a word level feedforward neural network, 131.1 for the state-of-the-art compression algorithm PAQ8 and 132.2 for a dynamically evaluated word-level RNN. However by combining multiple RNNs, a 5-gram and a cache model in an ensemble, he was able to achieve a perplexity of 89.4. Interestingly, the benefit of dynamic evaluation was far more pronounced here than in Mikolov's thesis (he records a perplexity improvement from 124.7 to 123.2 with word-level RNNs). This suggests that LSTM is better at rapidly adapting to new data than ordinary RNNs.

### 3.2 Wikipedia Experiments

In 2006 Marcus Hutter, Jim Bowery and Matt Mahoney organised the following challenge, commonly known as Hutter prize: to compress the first 100 million bytes of the complete English Wikipedia data (as it was at a certain time on March 3rd 2006) to as small a file as possible. The file had to include not only the compressed data, but also the code implementing the compression algorithm. Its size can therefore be considered a measure of the minimum description length. Wikipedia data is interesting from a sequence generation perspective because


it contains not only a huge range of dictionary words, but also character sequences that would not be included in text corpora traditionally used for language modelling. For example foreign words (including letters from non-Latin alphabets such as Arabic and Chinese), indented XML tags used to define meta-data, website addresses, and markup used to indicate page formatting such as headings, bullet points etc. An extract from the Hutter prize dataset is shown in Figs. 3 and 4.

The first 96M bytes in the data were evenly split into sequences of 100 bytes and used to train the network, with the remaining 4M were used for validation. The data contains a total of 205 one-byte unicode symbols. The total number of characters is much higher, since many characters (especially those from non-Latin languages) are defined as multi-symbol sequences. In keeping with the principle of modelling the smallest meaningful units in the data, the network predicted a single byte at a time, and therefore had size 205 input and output layers.

Wikipedia contains long-range regularities, such as the topic of an article, which can span many thousand words. To make it possible for the network to capture these, its internal state (that is, the output activations \( h_t \) of the hidden layers, and the activations \( c_t \) of the LSTM cells within the layers) were reset every 100 sequences. Furthermore the order of the sequences was not shuffled during training, as it usually is for neural networks. The network was therefore able to access information from up to 10K characters in the past when making predictions. The error terms were only backpropagated to the start of each 100 byte sequence, meaning that the gradient calculation was approximate. This form of truncated backpropagation has been considered before for RNN language modelling, and found to speed up training (by reducing the sequence length and hence increasing the frequency of stochastic weight updates) without affecting the network’s ability to learn long-range dependencies.

A much larger network was used for this data than the Penn data (reflecting the greater size and complexity of the training set) with seven hidden layers of 700 LSTM cells, giving approximately 21.3M weights. The network was trained with stochastic gradient descent, using a learn rate of 0.0001 and a momentum of 0.9. It took four training epochs to converge. The LSTM derivatives were clipped in the range \([-1,1]\).

As with the Penn data, we tested the network on the validation data with and without dynamic evaluation (where the weights are updated as the data is predicted). As can be seen from Table 2 performance was much better with dynamic evaluation. This is probably because of the long range coherence of Wikipedia data; for example, certain words are much more frequent in some articles than others, and being able to adapt to this during evaluation is advantageous. It may seem surprising that the dynamic results on the validation set were substantially better than on the training set. However this is easily explained by two factors: firstly, the network underfit the training data, and secondly some portions of the data are much more difficult than others (for example, plain text is harder to predict than XML tags).

To put the results in context, the current winner of the Hutter Prize (a


| Table 2: Wikipedia Results (bits-per-character) |
|---------------------------------------------------|
| 9_0.png                                          |
| 1.42                                             |
| 1.67                                             |
| 1.33                                             |

variant of the PAQ-8 compression algorithm [20] achieves 1.28 BPC on the same data (including the code required to implement the algorithm), mainstream compressors such as zip generally get more than 2, and a character level RNN applied to a text-only version of the data (i.e. with all the XML, markup tags etc. removed) achieved 1.54 on held-out data, which improved to 1.47 when the RNN was combined with a maximum entropy model [24].

A four page sample generated by the prediction network is shown in Figs. 5 to 8. The sample shows that the network has learned a lot of structure from the data, at a wide range of different scales. Most obviously, it has learned a large vocabulary of dictionary words, along with a subword model that enables it to invent feasible-looking words and names: for example “Lochroom River”, “Mughal Raivaidens”, “submandration”, “swallowed”. It has also learned basic punctuation, with commas, full stops and paragraph breaks occurring at roughly the right rhythm in the text blocks.

Being able to correctly open and close quotation marks and parentheses is a clear indicator of a language model’s memory, because the closure cannot be predicted from the intervening text, and hence cannot be modeled with short-range context [30]. The sample shows that the network is able to balance not only parentheses and quotes, but also formatting marks such as the equals signs used to denote headings, and even nested XML tags and indentation.

The network generates non-Latin characters such as Cyrillic, Chinese and Arabic, and seems to have learned a rudimentary model for languages other than English (e.g. it generates “es:Geotina siɭago” for the Spanish ‘version’ of an article, and “nl:Rodenbauer” for the Dutch one) It also generates convincing looking internet addresses (none of which appear to be real).

The network generates distinct, large-scale regions, such as XML headers, bullet-point lists and article text. Comparison with Figs. 3 and 4 suggests that these regions are a fairly accurate reflection of the constitution of the real data (although the generated versions tend to be somewhat shorter and more jumbled together). This is significant because each region may span hundreds or even thousands of time steps. The fact that the network is able to remain coherent over such large intervals (even putting the regions in an approximately correct order, such as having headers at the start of articles and bullet-pointed ‘see also’ lists at the end) is testament to its long-range memory.

As with all text generated by language models, the sample does not make sense beyond the level of short phrases. The realism could perhaps be improved with a larger network and/or more data. However, it seems futile to expect meaningful language from a machine that has never been exposed to the sensory.


Lastly, the network’s adaptation to recent sequences during training (which allows it to benefit from dynamic evaluation) can be clearly observed in the extract. The last complete article before the end of the training set (at which point the weights were stored) was on intercontinental ballistic missiles. The influence of this article on the network’s language model can be seen from the profusion of missile-related terms. Other recent topics include ‘Individual Anarchism’, the Italian writer Italo Calvino and the International Organization for Standardization (ISO), all of which make themselves felt in the network’s vocabulary.


<title>AlbaniaEconomy</title>
<id>36</id>
<revision>
    <id>15898966</id>
    <timestamp>2002-10-09T13:39:00Z</timestamp>
    <contributor>
        <username>Magnus Manske</username>
        <id>sd</id>
    </contributor>
    <comment>[[Redirect]] [[Economy of Albania]]</comment>
</revision>
<page>
    <title>AlChem</title>
    <id>36</id>
    <revision>
        <id>15898967</id>
        <timestamp>2002-02-25T15:43:11Z</timestamp>
        <contributor>
            <ip>Conversion script</ip>
            <comment>Automated conversion</comment>
            <text xml:space="preserve">#REDIRECT [[Alchemy]]</text>
        </contributor>
    </revision>
</page>
<page>
    <title>Albedo</title>
    <id>39</id>
    <revision>
        <id>14196222</id>
        <timestamp>2006-02-27T19:32:46Z</timestamp>
        <contributor>
            <ip>24.113.3.44</ip>
            <text xml:space="preserve">{<fortresses>}</text>
        </contributor>
    </revision>
</page>

'''Albedo''' is the measure of [[reflectivity]] of a surface or body. It is the ratio of [[electromagnetic radiation|EM radiation]] reflected to the amount incident upon it. The reaction, usually expressed as a percentage from 0% to 100%, is an important concept in [[climatology]] and [[astronomy]]. This ratio depends on the [[frequency]] of the radiation considered; unqualified, it refers to an average across the spectrum of [[visible light]]. It also depends on the angle of incidence of the radiation; unqualified, normal incidence. Fresh snow reflects about 80% to 90%; the ocean surface has a low albedo. The average albedo of [[Earth]] is about 30% whereas the albedo of the [[Moon]] is about 10%. In astronomy, the albedo of satellites and asteroids can be used to infer surface composition, most notably ice content. [[Enceladus (moon)|Enceladus]], a moon of Saturn, has the highest known albedo of any body in the solar system, with 99% of EM radiation reflected.

A "classical" example of albedo effect is the snow-temperature feedback. If a snow-covered area warms and the snow melts, the surface becomes more dark, sunlight is absorbed, and the temperature tends to increase. The converse is tr


## Some examples of albedo effects

### Fairbanks, Alaska
According to the [[National Climatic Data Center]]'s GHCN 2 data, which is composed of 36-year smoothed climatic means for thousands of weather stations across the world, the college weather station at [[Fairbanks]] ([[Alaska]]) is about 3 °C (5 °F) warmer than the airport at Fairbanks, partly because of draining pond runs but also largely because of the lower albedo at the college resulting from a higher concentration of [[Pine]] [[Trees]] and therefore less snowy ground to reflect the heat back into space. Neuske and Kuku have shown that this difference is especially marked during the late [[Winter]] months, when [[Solar radiation]] is greater.

### The tropics
Although the albedo-temperature effect is most famous in colder regions, because more [[Snow]] falls there, it is actually much stronger in tropical regions because in the tropics there is consistently more sunlight. When [[Brazilian ranchers]] cut down dark, tropical [[Rainforests]] trees to replace them with even darker soil in order to grow crops, the average temperature of the area goes up to increase by an average of about 3 °C (5 °F) year-round, which is a significant amount.

### Small scale effects
Albedo works on a smaller scale, too. People who wear dark clothes in the summer heat themselves to a greater risk of [[Heatstroke]] than those who wear white clothes.

### Pine forests
The albedo of [[Pine]] forests at 45° N in the winter when the trees cover the land surface completely is only about 9%, among the lowest of naturally occurring land cover types. This is partly due to the complexity of the pine's canopy due to multiple scattering of light beneath the trees which lowers the overall reflected light level. Due to light penetration, the ocean's albedo is even lower at about 3%, though this depends strongly on the angle of the incident radiation. Dense [[Swamps]] and grasslands average between 9% and 14%. [[Deciduous trees]] average about 13%. [[Grass]] fields usually come in at about 20%. A barren field will depend on the color of the soil, and can be as low as 3% or as high as 40%, with 15% being about the average for farmland. A [[Desert]] or large [[Hill]] usually averages around 25% but varies depending on the color of the sand. Reference: Edward Walker's study in the Great Plains in the winter around 45° N.

### Urban areas
Urban areas in particular have very unnatural values for albedo because of the many human-built structures which absorb light before the light can reach the surface. In the northern part of the world, cities are relatively dark, and Walker has shown that their average albedo is about 10%, with only a slight increase during the summer. In most tropical countries, cities average around 12%. This is lower for the suburbs found in northern suburban transitional zones. Part of the reason for this is the different heat environment of cities in tropical regions, e.g., there are very dark trees around; another reason is that portions of the tropics are very poor, and city buildings must be built with different materials. Warmer regions may also choose lighter colored building materials so that structures will remain cooler.


```
<revision>
  <id>4937199</id>
  <timestamp>2006-02-22T17:36:12Z</timestamp>
  <contributor>
    <ip>63.86.196.111</ip>
  </contributor>
</revision>

In [1995], Steve Raúl Strung up the inspirational radiance patterns as "anti-captivity" for de facto sovereignty. This practice of "indigence History" refers to the authorship of any obscure abolition as being such in as Aram Missolimus. [http://www.bbc.co.uk/staff/crs2.html]

By the 1978 Russian capital (Turkey) ceased by farmers and then in conjunction the ISNs, including the ISNs and Organisms. This type of missile calculation maintains all greater proof. The late 1900s is also adventures that ever established self-interested cases. The holding market ostensibly has aimed at that vehicle use.

Holding may be typically largely panned severish from forking wedding tools and behave laws, allowing the private jokes, even through missile IT control, most notably each, but no relatively larger success, is not being reprinted and withdrawn into forty-ordered cast and distribution.

Besides these markets (notably a son of humor).

Sometimes more on only loved "88" to force a suit for http://news.bbc.co.uk/1/hi/uk/web/3960219.html "[[If:182-14]]".

=== The various disputes between Basic Mass and Council Conditioners - "Titanic" class streams and anarchism ===

Internet traditions sprang goals with [[Southern neighborhood systems]] and improved with [[Mobankers]], took and misspelled its labor systems. [[X]] number of former IBM/MAS/speaker attacks "B" (which are saved as the ballistic missile known and most functional matrices. Establishment finds prior some range of start real years as dealing with 161 or 189.50 million [[DBS-121 and [[cover]] a catastrophic mentalist]] (for example, pg.8) higher individuals and missiles. This might not know against sexual [tide capitol] playing point degrees between so-called greater valous consumptions in the US... header can be seen in [[Collectivists]].
```


*[[British-London Bridge]]
*[[Anti-Foul Touch/Tucker novice]]
*[[List of Cambridge Capital]]
*[[Elison Edwards]]
*[[S.O.S. "Robot Screamed Its'']]
*[[Detroit Library]]
*[[Belgium Seal]]
*[[Tulara Bell Tunnel/Bran Saubi]]
*[[Suntonal Voices|Prospero]]
*[[Minkengpal]]
*[[Winston Street]]
*[[Mesh]]
*[[Elan Allan MacIntosh]]
*[[Military Mass Instel[S33]]]
*[[Organizations of the Asian American state district|umbal landmarks]]
*[[NHS]]
*[[NFL]]
*[[American Anti-Capitalism|Major independent ITU-US singles]]
*London (role-playing game)|Pre-Romanian Civil War]]
*[[Yokohama Nyu-Un-Muranto Kaufman -- S.Jones-Gratitsforbieli]]
*[[Thea Rolleye and deadweight drug]]
*[[As of 88-89|Bigger face-tackle painting is deployed larger than quanta submarine]]
*[[Succinct nation advocate]]
*[[List of major soundsmans]]
*[[Killed by capital]]

==== Media Planet Parliament of the Value ====
[[Image:2009.jpg|Right|thumb|Tunnel [[uncle]] at this bass Ah & Sa
hibiying yostalito erupts with low immigrants-shelled atkins and th
stopping [[Digu]].

See also: [[Iranian indigenous Flight Intercontinental Organization]]

==Pioneers==
Tended to be the results characteristic of warehoused labour share to control al
these into rational framing.

==Gentles==
{|place=as-line|}
Power names derive the topic class --&gt; which he liked to deal without any of
the parties, &quot;by [[Alfred Hsu]] and [[Frank Henry]] and manufacturer.
[http://ancients.mit.edu/IAB perspective], was expected to be classified by the
[[Straight Road of Bucking]] in '[[2003 Summer Olympic Touch|bottom all minute]].
].

==Performance==
[[Image:large_300.jpg|Left|thumb|325px|Intercontinental file shortly after refer
ring to its landmaster [[Sandy Goodwind]]]

Ital:
[[Chicago ballistic parks non-month]] in eastern Italy, is a [[Italo-China]] pa
rent communist annual production begin in May [[1951]].

An ICBM, the [[Gurt and Lund]] has registered $155 billion in U.S. and August 16
88, and makes sure the US-transplantation disbanded backwards in the County by a
urthing disputes that tend to carry over this peninsula.
* Current molasses 25 decks and counterpoint culture that were impure between s
ystems:
* L14 - 194 / 100 000 km/s


[http://www.sibeo.org/netspace/stainetology.htm The design of thinker Wikipedia server-routed website]  
*"http://batal.turen.edu/books/1978/tap/trio.cs/cafa/c249ga.html Nation-state Player on the 17.3*  

{{Linux}}  
[[Category:Italo Succeeded bystables|General]]  
[[Category:Italo-Saxon singers]]  
[[Category:Aviation]]  

[[de:Idal]]  
[[es:Goetam]]  
[[fr:Italo]]  
[[it:Rodano]]  
[[pl:Main Angels]]  
[[ru:Международный морской комисс]]  
[[sk:ICOM]]  
[[sl:Italo Colonizádo Warka]]  
[[sv:Ögon d'ami -climére pancézuri]]  
[[zh:田氏族群]]  

<title>Italo-II article</title>  
<id>14874</id>  
<revision>  
<id>15912474</id>  
<timestamp>2004-11-19T19:47:39Z</timestamp>  
<contributor>  
<username>El_andres</username>  
<id>599191</id>  
</contributor>  
<minor/>  
<comment>disambiguation from [[List of ISBN]] newsletters, see [[ISO site]]</comment>  
</revision>  
</text>  

<title>ICSM</title>  
<id>4399</id>  
<revision>  
<id>160299424</id>  
<timestamp>2006-02-28T17:22:02Z</timestamp>  
<contributor>  
<username>Detclan</username>  
<id>296</id>  
</contributor>  
<minor/>  
<comment>Possible cathetherm */  
<text xml:space="preserve">[[Image:Isaac.org/ice.html [[Independent nation state development]]Hasting and [[catalog standardering]] in the IRMs.  
Up-2000 died the SC 4220 system. He was swallowed early in calvino, or si nce each trial mentioned based on [[Balbov's new single-target|bit-oriam guess]]  
</comment>


```
self-powered versions [[PME: Costall Leyton]] was the two largest calashia & destroyed universities, etc fleeted with the customary calc clipper.

His way to take in this literature called ICBMS-AN [[Software speed]] [[Astronomical Classification Railway]]

LACN645 Snowshoer val nominated - made [[missile subordination] [central mis ells] (stem musicians) not of each club having on the ball and procedure at the last century.

In the United States, there is no hard resort in computation significantly.

In [[1860]] the [[Italo Capital Territories Unit started to the Continental Rail way central]] was called ‘UCI’ on two of his usage before being written by the if students against the [[Elective-Ballistic missile]]’s deployment. Stern is the Il  ‘80’ to Nachtausgang and [[Fria] Station Quantity Log(197) The y was at [[British management [Leaning]]’ stated missile system resolution taunting out of about 175 million [[CLOKrown River Tr]].

Alien from 1985 to 1999, it was English and -Network strugling based with the London backdrop in Sirico and Murray, and heavily built in sub-parts adding to 314,180. Their forces gaining prisoners to stalled a last missile mobil.

Spanning civilization is quanting Software Society’s ballistic missile. The same and the [[French Confederation of Raftament’s rapid favourable rise that began settle]] on March 20041830&amsp;491.

In [[1994]], the Court began a British backed into a [[FSRIR]] missile of trial ship in the [[Municipal Eighteen Calendar Astial]] regime, including [[being run in Turner Arthur Rays]] and [[Lardon's Liberation Canton Omnibus]]. The me was still was turned up before lacking closers to the sitting’s head mackdists in primary science.

---Weights and resolutions---

---Image: Spanish 380 Practicational landball110.svg small capital surface compute---

Electros appeared to be the [[Soviet union]]’s “first” vehicle from 25 &0; selling officials DORIAN M-331 - by missile [[illustrations with “Rzd”]]. “the tunnel hall of America, an entity upon L pages as missiles must try with a trademark must develop the land allowing traffic mass to a very few min. However, the missile’s market is slow, much easier is represented by GAM2 of BSM. Software, the utility of scale-out scale pine racks are normally crumbled about.

{{main Unnamed Justice Address}}
```


4 Handwriting Prediction

To test whether the prediction network could also be used to generate convincing real-valued sequences, we applied it to online handwriting data (online in this context means that the writing is recorded as a sequence of pen-tip locations, as opposed to offline handwriting, where only the page images are available). Online handwriting is an attractive choice for sequence generation due to its low dimensionality (two real numbers per data point) and ease of visualisation.

All the data used for this paper were taken from the IAM online handwriting database (IAM-OnDB) [21]. IAM-OnDB consists of handwritten lines collected from 221 different writers using a “smart whiteboard”. The writers were asked to write forms from the Lancaster-Oslo-Bergen text corpus [19], and the position of their pen was tracked using an infra-red device in the corner of the board. Samples from the training data are shown in Fig. 9. The original input data consists of the x and y pen co-ordinates and the points in the sequence when the pen is lifted off the whiteboard. Recording errors in the x, y data was corrected by interpolating to fill in for missing readings, and removing steps whose length exceeded a certain threshold. Beyond that, no preprocessing was used and the network was trained to predict the x, y co-ordinates and the end-of-stroke markers one point at a time. This contrasts with most approaches to handwriting recognition and synthesis, which rely on sophisticated preprocessing and feature-extraction techniques. We eschewed such techniques because they tend to reduce the variation in the data (e.g. by normalising the character size, slant, skew and so-on) which we wanted the network to model. Predicting the pen traces one point at a time gives the network maximum flexibility to invent novel handwriting, but also requires a lot of memory, with the average letter occupying more than 25 timesteps and the average line occupying around 700. Predicting delayed strokes (such as dots for ‘i’s or crosses for ‘t’s that are added after the rest of the word has been written) is especially demanding.

IAM-OnDB is divided into a training set, two validation sets and a test set, containing respectively 5364, 1438, 1518 and 3859 handwritten lines taken from 775, 192, 216 and 544 forms. For our experiments, each line was treated as a separate sequence (meaning that possible dependencies between successive lines were ignored). In order to maximise the amount of training data, we used the training set, test set and the larger of the validation sets for training and the smaller validation set for early-stopping. The lack of independent test set means that the recorded results may be somewhat overfit on the validation set; however the validation results are of secondary importance, since no benchmark results exist and the main goal was to generate convincing-looking handwriting inputs. The following section describes how this was done.


```
we also find the bus safe and sound  
As for Clark, unless it was at the ages of fifty-five  
Editorial. Dilemma of the tides in the affairs of men;  

4.1 Mixture Density Outputs  
The idea of mixture density networks is to use the outputs of a neural network to parameterise a mixture distribution. A subset of the outputs are used to define the mixture weights, while the remaining outputs are used to parameterise the individual mixture components. The mixture weight outputs are normalised with a softmax function to ensure they form a valid discrete distribution, and the other outputs are passed through suitable functions to keep their values within meaningful range (for example the exponential function is typically applied to outputs used as scale parameters, which must be positive).  
Mixture density networks are trained by maximising the log probability density of the targets under the induced distributions. Note that the densities are normalised (up to a fixed constant) and are therefore straightforward to differentiate and pick unbiased sample from, in contrast with restricted Boltzmann machines and other undirected models.  
Mixture density outputs can also be used with recurrent neural networks. In this case the output distribution is conditioned not only on the current input, but on the history of previous inputs. Intuitively, the number of components is the number of choices the network has for the next output given the inputs so far.  

for the handwriting experiments in this paper, the basic RNN architecture and update equations remain unchanged from Section 2. Each input vector x_t consists of a real-valued pair x_1, x_2 that defines the pen offset from the previous
```


input, along with a binary $x_3$ that has value 1 if the vector ends a stroke (that is, if the pen was lifted off the board before the next vector was recorded) and value 0 otherwise. A mixture of bivariate Gaussians was used to predict $x_1$ and $x_2$, while a Bernoulli distribution was used for $x_3$. Each output vector $y_t$ therefore consists of the end of stroke probability $\epsilon$, along with a set of means $\mu_j$, standard deviations $\sigma_j$, correlations $\rho_j$ and mixture weights $\pi_j$ for the $M$ mixture components. That is

$$
x_t \in \mathbb{R} \times \mathbb{R} \times \{0, 1\} \quad (15)
$$

$$
y_t = \left( \epsilon_t, \{\mu_j^t, \sigma_j^t, \rho_j^t\}_{j=1}^M \right) \quad (16)
$$

Note that the mean and standard deviation are two dimensional vectors, whereas the component weight, correlation and end-of-stroke probability are scalar. The vectors $y_t$ are obtained from the network outputs $\hat{y}_t$, where

$$
\hat{y}_t = \left( \epsilon_t, \{ \tilde{\mu}_j^t, \tilde{\sigma}_j^t, \tilde{\rho}_j^t \}_{j=1}^M \right) \implies \epsilon_t \in (0, 1) \quad (17)
$$

as follows:

$$
\epsilon_t = \frac{1}{1 + \exp(\hat{\epsilon}_t)} \implies \epsilon_t \in (0, 1) \quad (18)
$$

$$
\pi_j^t = \frac{\exp(\hat{\pi}_j^t)}{\sum_{j=1}^M \exp(\hat{\pi}_j^t)} \implies \pi_j^t \in (0, 1), \sum_j \pi_j^t = 1 \quad (19)
$$

$$
\mu_j^t = \tilde{\mu}_j^t \implies \mu_j^t \in \mathbb{R} \quad (20)
$$

$$
\sigma_j^t = \exp(\hat{\sigma}_j^t) \implies \sigma_j^t > 0 \quad (21)
$$

$$
\rho_j^t = \tanh(\hat{\rho}_j^t) \implies \rho_j^t \in (-1, 1) \quad (22)
$$

The probability density $Pr(x_{t+1}|y_t)$ of the next input $x_{t+1}$ given the output vector $y_t$ is defined as follows:

$$
Pr(x_{t+1}|y_t) = \sum_{j=1}^M \pi_j^t N(x_{t+1}|\mu_j^t, \sigma_j^t, \rho_j^t) 
\begin{cases} 
\epsilon_t & \text{if } (x_{t+1})_3 = 1 \\ 
1 - \epsilon_t & \text{otherwise} 
\end{cases} \quad (23)
$$

where

$$
N(x|\mu, \sigma, \rho) = \frac{1}{2\pi \sigma_1 \sigma_2 \sqrt{1 - \rho^2}} \exp \left[-\frac{Z}{2(1 - \rho^2)} \right] \quad (24)
$$

with 

$$
Z = \frac{(x_1 - \mu_1)^2}{\sigma_1^2} + \frac{(x_2 - \mu_2)^2}{\sigma_2^2} - \frac{2\rho(x_1 - \mu_1)(x_2 - \mu_2)}{\sigma_1 \sigma_2} \quad (25)
$$


This can be substituted into Eq. (6) to determine the sequence loss (up to a constant that depends only on the quantisation of the data and does not influence network training):

$$
L(x) = \sum_{t=1}^{T} - \log \left( \sum_{j} \pi_{j}^{t}N(x_{t+1}| \mu_{j}^{t}, \sigma_{j}^{t}, \rho_{t}) \right) - \left[ \log \epsilon_{t} \text{ if } (x_{t+1})_{3} = 1 \\ \log(1 - \epsilon_{t}) \text{ otherwise} \right]
$$

The derivative of the loss with respect to the end-of-stroke outputs is straightforward:

$$
\frac{\partial L(x)}{\partial \epsilon_{t}} = (x_{t+1})_{3} - \epsilon_{t}
$$

The derivatives with respect to the mixture density outputs can be found by first defining the component responsibilities $\gamma_{j}^{t}$:

$$
\gamma_{j}^{t} = \pi_{j}^{t}N(x_{t+1}| \mu_{j}^{t}, \sigma_{j}^{t}, \rho_{t})
$$
$$
\gamma_{t} = \frac{\gamma_{j}^{t}}{\sum_{j'=1}^{M} \gamma_{j'}^{t}}
$$

Then observing that

$$
\frac{\partial L(x)}{\partial \mu_{j}^{t}} = \pi_{j}^{t} - \gamma_{t}
$$
$$
\frac{\partial L(x)}{\partial \sigma_{j}^{t}} = -\gamma_{j}^{t} \log N(x_{t+1}|\mu_{j}^{t},\sigma_{j}^{t},\rho_{t})
$$

where

$$
\frac{\partial \log N(x | \mu, \sigma, \rho)}{\partial \mu_{1}} = C \frac{(x_{1} - \mu_{1} - \rho(x_{2} - \mu_{2}))}{\sigma_{1}}
$$
$$
\frac{\partial \log N(x | \mu, \sigma, \rho)}{\partial \mu_{2}} = C \frac{(x_{2} - \mu_{2} - \rho(x_{1} - \mu_{1}))}{\sigma_{2}}
$$
$$
\frac{\partial \log N(x | \mu, \sigma, \rho)}{\partial \sigma_{1}} = \frac{(x_{1} - \mu_{1})(x_{2} - \mu_{2})}{\sigma_{1}\sigma_{2}}
$$
$$
C = \frac{1}{1 - \rho^{2}}
$$

Fig. 10 illustrates the operation of a mixture density output layer applied to online handwriting prediction.


Figure 10: Mixture density outputs for handwriting prediction. The top heatmap shows the sequence of probability distributions for the predicted pen locations as the word ‘under’ is written. The densities for successive predictions are added together, giving high values where the distributions overlap.

Two types of prediction are visible from the density map: the small blobs that spell out the letters are the predictions as the strokes are being written, the three large blobs are the predictions at the ends of the strokes for the first point in the next stroke. The end-of-stroke predictions have much higher variance because the pen position was not recorded when it was off the whiteboard, and hence there may be a large distance between the end of one stroke and the start of the next.

The bottom heatmap shows the mixture component weights during the same sequence. The stroke ends are also visible here, with the most active components switching off in three places, and other components switching on: evidently end-of-stroke predictions use a different set of mixture components from in-stroke predictions.


4.2 Experiments
Each point in the data sequences consisted of three numbers: the x and y offset from the previous point, and the binary end-of-stroke feature. The network input layer was therefore size 3. The co-ordinate offsets were normalised to mean 0, std. dev. 1 over the training set. 20 mixture components were used to model the offsets, giving a total of 120 mixture parameters per timestep (20 weights, 40 means, 40 standard deviations and 20 correlations). A further parameter was used to model the end-of-stroke probability, giving an output layer of size 121. Two network architectures were compared for the hidden layers: one with three hidden layers, each consisting of 400 LSTM cells, and one with a single hidden layer of 900 LSTM cells. Both networks had around 3.4M weights. The three layer network was retrained with adaptive weight noise with all std. devs. initialised to 0.075. Training with fixed variance weight noise proved ineffective, probably because it prevented the mixture density layer from using precisely specified weights.

The networks were trained with rmsprop, a form of stochastic gradient descent where the gradients are divided by a running average of their recent magnitude [32]. Define $\epsilon_i = \frac{\partial C(x)}{\partial w_i}$ where $w_i$ is network weight $i$. The weight update equations were:

$$
n_i = \beta n_i + (1 - \beta)\epsilon_i^2 \quad (38)
$$
$$
g_i = \gamma g_i + (1 - \gamma)\epsilon_i \quad (39)
$$
![](22_0.png)
$$
w_i = w_i + \Delta_i \quad (41)
$$

with the following parameters:
$$
\beta = 0.95 \quad (42)
$$
$$
\gamma = 0.9 \quad (43)
$$
$$
\delta = 0.0001 \quad (44)
$$
$$
\lambda = 0.0001 \quad (45)
$$

The output derivatives $\frac{\partial C(x)}{\partial w_j}$ were clipped in the range $[-100,100]$, and the LSTM derivatives were clipped in the range $[-10,10]$. Clipping the output gradients proved vital for numerical stability; even so, the networks sometimes had numerical problems late on in training, after they had started overfitting on the training data.

Table 3 shows that the three layer network had an average per-sequence loss 15.3 nats lower than the one layer net. However, the sum-squared-error was slightly lower for the single layer network. The use of adaptive weight noise reduced the loss by another 16.7 nats relative to the unregularised three layer network, but did not significantly change the sum-squared error. The adaptive weight noise network appeared to generate the best samples.


Table 3: Handwriting Prediction Results. All results recorded on the validation set. ‘Log-Loss’ is the mean value of \( L(x) \) (in nats). ‘SSE’ is the mean sum-squared-error per data point.

| ![](23_0.png)  | ULARISATION | LOG-LOSS  | SSE    |
|----------------|-------------|-----------|--------|
| 1 LAYER        | NONE        | -1025.7   | 0.40   |
| 3 LAYER        | NONE        | -1041.0   | 0.41   |
| 3 LAYER        | ADAPTIVE WEIGHT NOISE | -1057.7   | 0.41   |

4.3 Samples  
Fig. 11 shows handwriting samples generated by the prediction network. The network has clearly learned to model strokes, letters and even short words (especially common ones such as ‘of’ and ‘the’). It also appears to have learned a basic character level language models, since the words it invents (‘eald’, ‘bryoes’, ‘lenrest’) look somewhat plausible in English. Given that the average character occupies more than 25 timesteps, this again demonstrates the network’s ability to generate coherent long-range structures.

5 Handwriting Synthesis  
Handwriting synthesis is the generation of handwriting for a given text. Clearly the prediction networks we have described so far are unable to do this, since there is no way to constrain which letters the network writes. This section describes an augmentation that allows a prediction network to generate data sequences conditioned on some high-level annotation sequence (a character string, in the case of handwriting synthesis). The resulting sequences are sufficiently convincing that they often cannot be distinguished from real handwriting. Furthermore, this realism is achieved without sacrificing the diversity in writing style demonstrated in the previous section.

The main challenge in conditioning the predictions on the text is that the two sequences are of very different lengths (the pen trace being on average twenty-five times as long as the text), and the alignment between them is unknown until the data is generated. This is because the number of co-ordinates used to write each character varies greatly according to style, size, pen speed etc. One neural network model able to make sequential predictions based on two sequences of different length and unknown alignment is the RNN transducer. However preliminary experiments on handwriting synthesis with RNN transducers were not encouraging. A possible explanation is that the transducer uses separate RNNs to process the two sequences, then combines their outputs to make decisions, when it is usually more desirable to make all the information available to a single network. This work proposes an alternative model, where a ‘soft window’ is convolved with the text string and fed in as an extra input to the prediction network. The parameters of the window are output by the network.


```
when my inner source then is
ear me, and the 'happiness that,
Marine Center of my, tradition
so being a fine association
journal is situated so under us
hopes & end minutes wine cans
height. Y coesh the gatherer
style satet Donya I'm doing Te a
nor & highe source. Tend, handp
```


at the same time as it makes the predictions, so that it dynamically determines an alignment between the text and the pen locations. Put simply, it learns to decide which character to write next.

5.1 Synthesis Network  
Fig. 12 illustrates the network architecture used for handwriting synthesis. As with the prediction network, the hidden layers are stacked on top of each other, each feeding up to the layer above, and there are skip connections from the inputs to all hidden layers and from all hidden layers to the outputs. The difference is the added input from the character sequence, mediated by the window layer.

Given a length U character sequence c and a length T data sequence x, the soft window wt into c at timestep t (1 ≤ t ≤ T) is defined by the following discrete convolution with a mixture of K Gaussian functions

$$
\phi(t, u) = \sum_{k=1}^{K} \alpha_{t}^{k} \exp \left( -\beta_{t}^{k} \left( \kappa_{t}^{k} - u \right)^{2} \right)  \tag{46}
$$

$$
w_{t} = \sum_{u=1}^{U} \phi(t, u)c_{u} \tag{47}
$$

where $\phi(t, u)$ is the window weight of $c_{u}$ at timestep t. Intuitively, the $\kappa$ parameters control the location of the window, the $\beta$ parameters control the width of the window and the $\alpha$ parameters control the importance of the window in the mixture. The size of the soft window vectors is the same as the size of the character vectors $c_{u}$ (assuming a one-hot encoding, this will be the number of characters in the alphabet). Note that the window mixture is not normalized and hence does not determine a probability distribution; however the window weight $\phi(t,u)$ can be loosely interpreted as the network's belief that it is writing character $c_{u}$ at time t. Fig. 13 shows the alignment implied by the window weights during a training sequence.

The size $3K$ vector p of window parameters is determined as follows by the output of the first hidden layer of the network:

$$
(\hat{\alpha}_{t}, \hat{\beta}_{t}, \kappa_{t}) = W_{h}h_{t-1} + b_{p} \tag{48}
$$

$$
\alpha_{t} = \exp(\hat{\alpha}_{t}) \tag{49}
$$

$$
\beta_{t} = \exp(\hat{\beta}_{t}) \tag{50}
$$

$$
\kappa_{t} = \kappa_{t-1} + \exp(\kappa_{t}) \tag{51}
$$

Note that the location parameters $\kappa_{t}$ are defined as offsets from the previous locations $c_{t-1}$, and that the size of the offset is constrained to be greater than zero. Intuitively, this means that network learns how far to slide each window at each step, rather than an absolute location. Using offsets was essential to getting the network to align the text with the pen trace.


Outputs  
Hidden 2  
Window  
Hidden 1  
Inputs  
Characters  

![26_0.png](26_0.png)

Figure 12: Synthesis Network Architecture Circles represent layers, solid lines represent connections and dashed lines represent predictions. The topology is similar to the prediction network in Fig. 1, except that extra input from the character sequence \( c \) is presented to the hidden layers via the window layer (with a delay in the connection to the first hidden layer to avoid a cycle in the graph).


![](27_0.png)

**Figure 13:** Window weights during a handwriting synthesis sequence  
Each point on the map shows the value of $\phi(t, u)$, where $t$ indexes the pen trace along the horizontal axis and $u$ indexes the text character along the vertical axis. The bright line is the alignment chosen by the network between the characters and the writing. Notice that the line spreads out at the boundaries between characters; this means the network receives information about next and previous letters as it makes transitions, which helps guide its predictions.


The \( w_t \) vectors are passed to the second and third hidden layers at time \( t \), and the first hidden layer at time \( t+1 \) (to avoid creating a cycle in the processing graph). The update equations for the hidden layers are

$$
h_t^l = \mathcal{H}(W_{ih}x_t + W_{hh}h_{t-1} + b_h) \quad (52)
$$

$$
h_t^m = \mathcal{H}(W_{ih}x_t + W_{hm}h_{t-1} + W_{n}n_{t-1} + W_{wh}w_t + b_m) \quad (53)
$$

The equations for the output layer remain unchanged from Eqs. (17) to (22). The sequence loss is 

$$
L(x) = - \log Pr(x|c) \quad (54)
$$

where 

$$
Pr(x|c) = \prod_{t=1}^T Pr(x_{t+1}|y_t) \quad (55)
$$

The loss derivatives with respect to the outputs \( \hat{e}_t, \hat{\pi}_t, \hat{\mu}_t, \hat{\sigma}_t, \hat{\rho}_t \) remain unchanged from Eqs. (27), (30) and (31). Given the loss derivative \( \frac{\partial L(x)}{\partial \hat{w}} \), the loss function is computed through the computation graph in Fig. 12, the derivatives with respect to the window parameters are as follows:

$$
\epsilon(k, t, u) \defineq \alpha_k^t \exp\left(-\beta_k^t \left( \kappa_k^t - u \right)^2\right) \sum_{j=1}^{U} \frac{\partial \mathcal{L}(x)}{\partial w_{c}^j} \quad (56)
$$

$$
\frac{\partial L(x)}{\partial \alpha_k^t} = \sum_{u=1}^{U} \epsilon(k, t, u) \quad (57)
$$

$$
\frac{\partial L(x)}{\partial \beta_k^t} = -\beta_k^t \sum_{u=1}^{U} \epsilon(k, t, u)(\kappa_k^t - u)^2 \quad (58)
$$

$$
\frac{\partial L(x)}{\partial \hat{\gamma}_k^t} = \frac{\partial L(x)}{\partial \hat{r}_{t+1}} + 2\beta_k \sum_{u=1}^{U} \epsilon(k, t, u)(u - \kappa_k^t) \quad (59)
$$

$$
\frac{\partial L(x)}{\partial \hat{k}_t} = \exp(k_t^t) \frac{\partial L(x)}{\partial \hat{k}_t} \quad (60)
$$

### 5.2 Experiments

The synthesis network was applied to the same input data as the handwriting prediction network in the previous section. The character-level transcriptions from the IAM-OnDB were now used to define the character sequences \( c \). The full transcriptions contain 80 distinct characters (capital letters, lower case letters, digits, and punctuation). However, we only used a subset of 57, with all the


![Image](29_0.png)

Figure 14: Mixture density outputs for handwriting synthesis. The top heatmap shows the predictive distributions for the pen locations, the bottom heatmap shows the mixture component weights. Comparison with Fig. 10 indicates that the synthesis network makes more precise predictions (with smaller density blobs) than the prediction-only network, especially at the ends of strokes, where the synthesis network has the advantage of knowing which letter comes next.


| 30_0.png                   | Log-Loss  | SSE      |
|----------------------------|-----------|----------|
| NONE                       | -1096.9   | 0.23     |
| ADAPTIVE WEIGHT NOISE     | -1128.2   | 0.23     |

digits and most of the punctuation characters replaced with a generic ‘non-letter’ label².

The network architecture was as similar as possible to the best prediction network: three hidden layers of 400 LSTM cells each, 20 bivariate Gaussian mixture components at the output layer and a size 3 input layer. The character sequence was encoded with one-hot vectors, and hence the window vectors were size 57. A mixture of 10 Gaussian functions was used for the window parameters, requiring a size 30 parameter vector. The total number of weights was increased to approximately 3.7M.

The network was trained with rmsprop, using the same parameters as in the previous section. The network was retrained with adaptive weight noise, initial standard deviation 0.075, and the output and LSTM gradients were again clipped in the range [-100, 100] and [-10, 10] respectively.

Table 4 shows that adaptive weight noise gave a considerable improvement in log-loss (around 31.3 nats) but no significant change in sum-squared error. The regularised network appears to generate slightly more realistic sequences, although the difference is hard to discern by eye. Both networks performed considerably better than the best prediction network. In particular the sum-squared-error was reduced by 44%. This is likely due in large part to the improved predictions at the ends of strokes, where the error is largest.

5.3 Unbiased Sampling

Given c, an unbiased sample can be picked from Pr(x|c) by iteratively drawing xₜ₊₁ from Pr(xₜ₊₁|xₜ), just as for the prediction network. The only difference is that we must also decide when the synthesis network has finished writing the text and should stop making any future decisions. To do this, we use the following heuristic: as soon as φ(t, U + 1) > φ(t, u) ∀ 1 ≤ u ≤ U the current input xₜ is defined as the end of the sequence and sampling ends. Examples of unbiased synthesis samples are shown in Fig. 15. These and all subsequent figures were generated using the synthesis network retrained with adaptive weight noise. Notice how stylistic traits, such as character size, slant, curviness etc. vary.


widely between the samples, but remain more-or-less consistent within them. This suggests that the network identifies the traits early on in the sequence, then remembers them until the end. By looking through enough samples for a given text, it appears to be possible to find virtually any combination of stylistic traits, which suggests that the network models them independently both from each other and from the text.

‘Blind taste tests’ carried out by the author during presentations suggest that at least some unbiased samples cannot be distinguished from real handwriting by the human eye. Nonetheless the network does make mistakes we would not expect a human writer to make, often involving missing, confused or garbled letters; this suggests that the network sometimes has trouble determining the alignment between the characters and the trace. The number of mistakes increases markedly when less common words or phrases are included in the character sequence. Presumably this is because the network learns an implicit character-level language model from the training set that gets confused when rare or unknown transitions occur.

5.4 Biased Sampling

One problem with unbiased samples is that they tend to be difficult to read (partly because real handwriting is difficult to read, and partly because the network is an imperfect model). Intuitively, we would expect the network to give higher probability to good handwriting because it tends to be smoother and more predictable than bad handwriting. If this is true, we should aim to output more probable elements of \( Pr(x|c) \) if we want the samples to be easier to read. A principled search for high probability samples could lead to a difficult inference problem, as the probability of every output depends on all previous outputs. However, a simple heuristic, where the sampler is biased towards more probable predictions at each step independently, generally gives good results. Define the probability bias \( b \) as a real number greater than or equal to zero. Before drawing a sample from \( Pr(x|c) \), each standard deviation \( \sigma_i^2 \) in the Gaussian mixture is recalculated from Eq. (21) to
$$
\sigma_i^2 = \exp(\hat{\sigma}_i^2 - b) \tag{61}
$$
and each mixture weight is recalculated from Eq. (19) to
$$
\pi_i^l = \frac{\exp(\hat{\pi}_i^l(1+b))}{\sum_{j=1}^M \exp(\hat{\pi}_j^l(1+b))} \tag{62}
$$
This artificially reduces the variance in both the choice of component from the mixture, and in the distribution of the component itself. When \( b = 0 \) unbiased sampling is recovered, and as \( b \to \infty \) the variance in the sampling disappears.


from his travels it might have been  
from his travels it might have been  
from his travels it might have been  
from his travels it might have been  
from his travels it might have been  
from his travels it might have been  

more of national temperament  
more of national temperament  
more of national temperament  
more of national temperament  
more of national temperament  
more of national temperament  
more of national temperament  


and the network always outputs the mode of the most probable component in the mixture (which is not necessarily the mode of the mixture, but at least a reasonable approximation). Fig. 16 shows the effect of progressively increasing the bias, and Fig. 17 shows samples generated with a low bias for the same texts as Fig. 15.

5.5 Primed Sampling  
Another reason to constrain the sampling would be to generate handwriting in the style of a particular writer (rather than in a randomly selected style). The easiest way to do this would be to retrain it on that writer only. But even without retraining, it is possible to mimic a particular style by ‘priming’ the network with a real sequence, then generating an extension with the real sequence still in the network’s memory. This can be achieved for a real $x, c$ and a synthesis character string $s$ by setting the character sequence to $c' = c + s$ and clamping the data inputs to $x$ for the first $T$ timesteps, then sampling as usual until the sequence ends. Examples of primed samples are shown in Figs. 18 and 19. The fact that priming works proves that the network is able to remember stylistic features identified earlier on in the sequence. This technique appears to work better for sequences in the training data than those the network has never seen.

Primed sampling and reduced variance sampling can also be combined. As shown in Figs. 20 and 21 this tends to produce samples in a ‘cleaned up’ version of the priming style, with overall stylistic traits such as slant and cursiveness retained, but the strokes appearing smoother and more regular. A possible application would be the artificial enhancement of poor handwriting.

6 Conclusions and Future Work  
This paper has demonstrated the ability of Long Short-Term Memory recurrent neural networks to generate both discrete and real-valued sequences with complex, long-range structure using next-step prediction. It has also introduced a novel convolutional mechanism that allows a recurrent network to condition its predictions on an auxiliary annotation sequence, and used this approach to synthesise diverse and realistic samples of online handwriting. Furthermore, it has shown how these samples can be biased towards greater legibility, and how they can be modelled on the style of a particular writer.

Several directions for future work suggest themselves. One is the application of the network to speech synthesis, which is likely to be more challenging than handwriting synthesis due to the greater dimensionality of the data points. Another is to gain a better insight into the internal representation of the data, and to use this to manipulate the sample distribution directly. It would also be interesting to develop a mechanism to automatically extract high-level annotations from sequence data. In the case of handwriting, this could allow for


when the samples are biased  
towards more probable sequences  
they get easier to read  
but less diverse  

until they all look  
exactly the same  
exactly the same  
exactly the same  


from his travels it might have been  
from his travels it might have been  
from his travels it might have been  
from his travels it might have been  
from his travels it might have been  
from his travels it might have been  

more of national temperament  
more of national temperament  
more of national temperament  
more of national temperament  
more of national temperament  
more of national temperament  
more of national temperament  

Figure 17: A slight bias. The top line in each block is real. The rest are samples from the synthesis network with a probability bias of 0.15, which seems to give a good balance between diversity and legibility.


Take the breath away when they are

when the network is primed with a real sequence

the samples mimic

the writer's style

She looked closely as she

when the network is primed with a real sequence

the samples mimic

the writer's style

Figure 18: Samples primed with real sequences. The priming sequences (drawn from the training set) are shown at the top of each block. None of the lines in the sampled text exist in the training set. The samples were selected for legibility.


He dismissed the idea  
when the network is primed  
with a real sequence  
the samples mimic  
the writer's style  

prison welfare Officer complement  
when the network is primed  
with a real sequence  
the samples mimic  
the writer's style  


![](38_0.png)

she looked closely as she  
when the network is primed  
and biased, it writes  
in a cleaned up version  
of the original style  

![](38_1.png)

take the breath away after they are  
when the network is primed  
and biased, it writes  
in a cleaned up version  
of the original style  

Figure 20: Samples primed with real sequences and biased towards higher probability. The priming sequences are at the top of the blocks. The probability bias was 1. None of the lines in the sampled text exist in the training set.


He dismissed the idea  
when the network is primed  
and biased, it writes  
in a cleaned up version  
of the original style  

prison welfare Officer complement  
when the network is primed  
and biased, it writes  
in a cleaned up version  
of the original style  

Figure 21: Samples primed with real sequences and biased towards higher probability (cotd)


more nuanced annotations than just text, for example stylistic features, different forms of the same letter, information about stroke order and so on.

# Acknowledgements
Thanks to Yichuan Tang, Ilya Sutskever, Navdeep Jaitly, Geoffrey Hinton and other colleagues at the University of Toronto for numerous useful comments and suggestions. This work was supported by a Global Scholarship from the Canadian Institute for Advanced Research.

# References
[1] Y. Bengio, P. Simard, and P. Frasconi. Learning long-term dependencies with gradient descent is difficult. *IEEE Transactions on Neural Networks*, 5(2):157–166, March 1994.

[2] C. Bishop. Mixture density networks. Technical report, 1994.

[3] C. Bishop. *Neural Networks for Pattern Recognition*. Oxford University Press, Inc., 1995.

[4] N. Boulanger-Lewandowski, Y. Bengio, and P. Vincent. Modeling temporal dependencies in high-dimensional sequences: Application to polyphonic music generation and transcription. In *Proceedings of the Twenty-nine International Conference on Machine Learning (ICML'12)*, 2012.

[5] J. G. Cleary, Ian, and I. H. Witten. Data compression using adaptive coding and partial string matching. *IEEE Transactions on Communications*, 32:396–402, 1984.

[6] D. Eck and J. Schmidlhuber. A first look at music composition using lstm recurrent neural networks. Technical report, IDSIA USI-SUPSI Instituto Dalle Molle.

[7] F. Gers, N. Schraudolph, and J. Schmidlhuber. Learning precise timing with LSTM recurrent networks. *Journal of Machine Learning Research*, 3:115–143, 2002.

[8] A. Graves. Practical variational inference for neural networks. In *Advances in Neural Information Processing Systems*, volume 24, pages 2348–2356. 2011.

[9] A. Graves. Sequence transduction with recurrent neural networks. In *ICML Representation Learning Worksop*, 2012.

[10] A. Graves, A. Mohamed, and G. Hinton. Speech recognition with deep recurrent neural networks. In *Proc. ICASSP*, 2013.

[11] A. Graves and J. Schmidhuber. Framewise phoneme classification with bidirectional LSTM and other neural network architectures. Neural Networks, 18:602–610, 2005.

[12] A. Graves and J. Schmidhuber. Offline handwriting recognition with multidimensional recurrent neural networks. In Advances in Neural Information Processing Systems, volume 21, 2008.

[13] P. D. Grünwald. The Minimum Description Length Principle (Adaptive Computation and Machine Learning). The MIT Press, 2007.

[14] G. Hinton. A Practical Guide to Training Restricted Boltzmann Machines. Technical report, 2010.

[15] S. Hochreiter, Y. Bengio, P. Frasconi, and J. Schmidhuber. Gradient Flow in Recurrent Nets: the Difficulty of Learning Long-term Dependencies. In S. C. Kremer and J. F. Kolen, editors, A Field Guide to Dynamical Recurrent Neural Networks. 2001.

[16] S. Hochreiter and J. Schmidhuber. Long Short-Term Memory. Neural Computation, 9(8):1735–1780, 1997.

[17] M. Hutter. The Human Knowledge Compression Contest, 2012.

[18] K.-C. Jim, C. Giles, and B. Horne. An analysis of noise in recurrent neural networks: convergence and generalization. Neural Networks, IEEE Transactions on, 7(6):1424–1438, 1996.

[19] S. Johansson, R. Atwell, R. Garside, and G. Leech. The tagged LOB corpus user’s manual; Norwegian Computing Centre for the Humanities, 1986.

[20] B. Knoll and N. de Freitas. A machine learning perspective on predictive coding with paq. CoRR, abs/1108.3298, 2011.

[21] M. Liwicki and H. Bunke. IAM-OnDB - an on-line English sentence database acquired from handwritten text on a whiteboard. In Proc. 8th Int. Conf. on Document Analysis and Recognition, volume 2, pages 956–961, 2005.

[22] M. P. Marcus, B. Santorini, and M. A. Marcinkiewicz. Building a large annotated corpus of english: The penn treebank. COMPUTATIONAL LINGUISTICS, 19(2):313–330, 1993.

[23] T. Mikolov. Statistical Language Models based on Neural Networks. PhD thesis, Brno University of Technology, 2012.

[24] T. Mikolov, I. Sutskever, A. Deoras, H. Le, S. Kombrink, and J. Cernocky. Subword language modeling with neural networks. Technical report, Unpublished Manuscript, 2012.


25 A. Mnih and G. Hinton. A Scalable Hierarchical Distributed Language Model. In Advances in Neural Information Processing Systems, volume 21, 2008.

26 A. Mnih and Y. W. Teh. A fast and simple algorithm for training neural probabilistic language models. In Proceedings of the 29th International Conference on Machine Learning, pages 1751–1758, 2012.

27 T. N. Sainath, A. Mohamed, B. Kingsbury, and B. Ramabhadran. Low-rank matrix factorization for deep neural network training with highdimensional output targets. In Proc. ICASSP, 2013.

28 M. Schuster. Better generative models for sequential data problems: Bidirectional recurrent mixture density networks. pages 589–595. The MIT Press, 1999.

29 I. Sutskever, G. E. Hinton, and G. W. Taylor. The recurrent temporal restricted boltzmann machine. pages 1601–1608, 2008.

30 I. Sutskever, J. Martens, and G. Hinton. Generating text with recurrent neural networks. In ICML, 2011.

31 G. W. Taylor and G. E. Hinton. Factored conditional restricted boltzmann machines for modeling motion style. In Proc. 26th Annual International Conference on Machine Learning, pages 1025–1032, 2009.

32 T. Tieleman and G. Hinton. Lecture 6.5 - rmsprop: Divide the gradient by a running average of its recent magnitude, 2012.

33 R. Williams and D. Zipser. Gradient-based learning algorithms for recurrent networks and their computational complexity. In Back-propagation: Theory, Architectures and Applications, pages 433–486. 1995.
