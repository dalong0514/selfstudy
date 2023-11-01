## 安装 llama.cpp

[ggerganov/llama.cpp: Port of Facebook's LLaMA model in C/C++](https://github.com/ggerganov/llama.cpp)

下载源代码。

git clone https://github.com/ggerganov/llama.cpp.git

下载源代码后，编译支持 GPU 加速的版本。之后就会有一个叫作 main 的命令行文件出现在根目录下。

请注意，下面的编译方法中的 LLAMA_METAL 是供 M 系列芯片用户使用的 GPU 加速，如果你的电脑是 Linux 或者 Windows 请查阅官方文档中的编译选项自行调整。

make clean && LLAMA_METAL=1 make

### 下载模型

你要下载模型，比如下载 TheBloke 这个作者编译的 gguf 格式，链接是 https://huggingface.co/TheBloke/Mistral-7B-Instruct-v0.1-GGUF/tree/main。具体细节可以看这个仓库的 README。其中，仓库中的不同版本是不同的量化策略，有不一样的性能损耗。在检索模型的时候如果你想用 llama.cpp 推理，可以搜索 gguf 这个关键词。

因为模型很大，不能全部下载下来。只下载某个模型的某一个量化，比如 TheBloke/Mistral-7B-Instruct-v0.1-GGUF 这个仓库中的 mistral-7b-instruct-v0.1.Q5_K_M.gguf 这个模型。

你需要用到一个工具，叫 huggingface-cli，应该叫 huggingface_hub，这个我记得 pip 装一下就可以了，或者 pipx 也可以。下载好的模型放在 llama.cpp/models 里。huggingface-cli 的参数照抄一下就好了。

huggingface-cli download TheBloke/Mistral-7B-Instruct-v0.1-GGUF mistral-7b-instruct-v0.1.Q5_K_M.gguf --local-dir . --local-dir-use-symlinks False
如果下载中途不幸出错，则在原指令的后面加上 “--resume-download” 就可以接着中断的地方继续下载了，否则就得从头开始下载。

### 推理模型

运行模型的最小命令是，其中用了 mistral 模型的 7b 版本的 Q5 量化，也就是 mistral-7b-instruct-v0.1.Q5_K_M。

export MODEL=models/mistral-7b-instruct-v0.1.Q5_K_M.gguf
export PROMPT="Who are you? What can you do?"
./main \
    --threads 8 \
    --n-gpu-layers 1 \
    --model "${MODEL}" \
    --color \
    --ctx-size 2048 \
    --temp 0.7 \
    --repeat_penalty 1.1 \
    --n-predict -1 \
    --prompt "[INST] ${PROMPT} [/INST]"

如果你是数量工，则建议把上面的命令配置为一个命令行的 shell 脚本，执行起来方便。

### 自检清单

1、下载模型前，请给命令行上代理。

2、配置完成后，你的本地应该有一个 llama.cpp 文件夹，其中包括：

  - llama.cpp/main 是你编译出来用于推理的命令行程序。
  - llama.cpp/model/xxxxx.gguf 存放你用于推理的模型。
  - 如下图所示：

### 其他 QA

- TheBloke 的转化能确保和原本的没有区别吗？大部分情况一样。

- 反馈： Linux 用户编译的时候，直接进入目录，执行 make clean 命令。LLAMA_METAL 是苹果的，执行会报错。

ChangeLog

- 231031 Alex fix

- 231026 Alex init
