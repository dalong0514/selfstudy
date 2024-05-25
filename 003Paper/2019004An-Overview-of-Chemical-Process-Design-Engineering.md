## An Overview of Chemical Process Design Engineering

David Mody, Queen’s University, David.Mody@chee.queensu.ca 

David S. Strong, Queen’s University, strongd@appsci.queensu.ca

### Abstract

The nature of Chemical Process Design Engineering requires that it utilize methods of design that sometimes differ from product design, yet clearly, many overlaps exist. This paper describes the general procedure for designing a chemical plant, the common design documents, and today’s tools for achieving a chemical plant design. Parallels and differences between process and product design are highlighted.

化学工艺设计工程的特点在于，有时它采用的设计方法与产品设计不同，但两者之间也有许多相似之处。本文介绍了化工厂设计的一般流程、常见的设计文件以及当前用于实现化工厂设计的工具，并重点比较了工艺设计与产品设计的异同。

### 01. Introduction

Design in its most simplistic viewpoint is composed of the following steps:

1. Determine the problem and its constraints.

2. Generate potential solutions.

3. Develop sufficient detail that solutions can be compared and eliminated.

4. Implement the preferred solution.

Product Design and Chemical Process Design often share the objective of producing a product for a commercial purpose. In many ways the two are similar, but process design, as typically taught in the universities, has historically emphasised the manufacture of a known product more than the development of a completely new product. It should be noted that, to the chemical process engineer the word ‘product’ is meant to encompass not only chemicals, but also energy or other commercially useful “things”. A generic process can be described as follows:

Figure 1. Generic Process

The invention of new chemical products (e.g. Nylon® or Lycra®) to suit specific end needs or properties such as strength, weight, colour fastness, abrasion resistance, high temperature capability, or flexibility, etc. is typically the role of the molecular/chemical designers who are usually located in chemistry laboratories and research centers. However, the design of the modification steps to generate the chemical product in production quantities is more firmly in the domain of the process design engineer. In the chemical industry the product and its manufacturing process are so intrinsically linked that these two roles sometimes blur into one ‘research and development’ person. However, as we shall see below, process design engineers sometimes find themselves in different situations, such as:

1. The Output is known and a desirable route to its production is to be designed, including selecting appropriate inputs. 

2. The Inputs are known and a desirable output is required along with 1. 

3. The desirable properties are known and a product along with its manufacturing process is to be designed. 

4. The inputs, outputs and route are known, but an optimization of the route is to be performed.

In either Product or Process Engineering, the primary objective of the design engineer is usually to produce something at the lowest possible cost, with the most commercially desirable attributes, and to do so in a way that meets all applicable laws and standards and ensures safety and protection of society.

In the realm of the process designer, the objectives can be open ended, such as producing a more environmentally friendly or safer stream, or to meet a legislative requirement. But, more commonly, the end product is known and the route to its production is being designed, which tends to make the design problem less open ended. Another example of an open ended design problem would be when the objective of a process is to make use of a waste stream in any manner possible, which may or may not, require changing it’s molecular properties (i.e. convert it to a useful product, burn it to recover energy, or digest it using biological means). In such a situation, the feeds are defined and the product of the process is unknown. In either of these examples, there is a strong sense of the ‘product’ that will be produced and consumed, but this is not always the case.

Another potential situation for process design engineers is the optimization of a process. By its very nature, the objective of improving efficiency (less waste, less raw materials, less energy use, greater production rate, etc.), or improving safety, necessitates the use of creative thinking and engineering tools to satisfy the problem definition and constraints. In these situations, the final “product” may be performance criteria, and therefore the process itself becomes the product of the performance requirement. An analogy in “hard product” production would be improvement in the production process for higher throughput, lower scrap rate, higher quality, or lower cost.

Since the objectives of process and product design typically overlap, it follows that the engineering process to achieve the desired results should be common. In the next section some of the steps taken by the process engineer during the typical chemical plant process design will be discussed. The reader familiar with product design and/or manufacture is invited to draw comparisons with their own experience.

01 引言

设计从最简单的角度来看，可以分为以下几个步骤：

1. 确定问题及其限制条件。

2. 提出潜在的解决方案。

3. 详细开发各个方案，以便进行比较和筛选。

4. 实施最佳方案。

产品设计和化学工艺设计通常都以商业目的为导向，生产产品。两者在许多方面是相似的，但在大学中教授的工艺设计通常更注重已知产品的制造，而不是全新产品的开发。需要注意的是，化学工艺工程师所说的「产品」不仅包括化学品，还包括能源或其他具有商业价值的「东西」。一个通用的过程可以描述为：

图 1. 通用过程

新化学产品（例如尼龙 ® 或莱卡 ®）通常是为了满足特定需求或属性（如强度、重量、色牢度、耐磨性、高温能力或柔韧性等）而发明的。这通常是由分子/化学设计师在化学实验室和研究中心完成的。然而，设计生产这些产品所需的修改步骤通常是工艺设计工程师的职责。在化学工业中，产品及其制造过程紧密相连，以至于这两个角色有时会合二为一，成为「研究和开发」人员。然而，正如我们将在下文中看到的，工艺设计工程师有时会面临不同的情况，例如：

1. 已知输出，需要设计一条理想的生产路线，包括选择适当的输入。

2. 已知输入，需要设计一个理想的输出以及生产路线。

3. 已知理想属性，需要设计一个产品及其制造过程。

4. 已知输入、输出和路线，但需要对路线进行优化。

无论是产品还是工艺工程，设计工程师的主要目标通常是以尽可能低的成本生产出具备最具商业吸引力属性的产品，并确保生产过程符合所有适用法律和标准，保障社会的安全和保护。

在流程设计的领域，目标可能是开放性的，比如生产出更环保或更安全的产品，或满足相关法规的要求。然而，更常见的情况是，明确了最终产品，设计师只需规划出其生产路径，这种设计问题相对更具体。另一个开放性设计问题的例子是，目标是以任何可能的方式利用废物流，比如将其转化为有用产品，燃烧回收能量，或通过生物方法消化。在这种情况下，输入是已知的，但最终产品是不确定的。在这些例子中，虽然最终的「产品」是明确的，但这并不总是如此。

流程设计工程师还可能面临另一种情况，即优化现有流程。无论是为了提高效率（如减少废物、降低原材料消耗、减少能量使用、提高生产率等）还是提高安全性，都需要创造性思维和工程工具来解决问题和满足约束条件。在这种情况下，最终的「产品」可能是性能标准，因此流程本身就成为性能要求的产物。如果用「硬产品」的生产过程来类比，则可以理解为提高生产效率、降低废品率、提升产品质量或降低成本。

由于流程设计和产品设计的目标通常是重叠的，因此实现这些目标的工程过程也是类似的。在接下来的部分，我们将讨论流程工程师在典型化工厂流程设计中采取的一些步骤。熟悉产品设计或制造的读者可以将其与自己的经验进行对比。

### 02. The Steps of Chemical Process Design

As with any engineering design problem, a goal is to eliminate non optimal solutions with as little “effort cost” as possible. This usually leads to an iterative, or “bootstrapping” design methodology that begins with a low level of detail in the solutions and progressively creates more and more detail of fewer possible solutions until an optimal one is found. During the design development, one of the key decision making tools is economic viability, and producing design information that assists in making that analysis is principal to any methodology. The process of design has the following goals:

Goal 1. Eliminate solutions with as little effort as possible.

Goal 2. Produce a financial estimate.

Goal 3. Understand the risk that the process poses to society and the environment.

Goal 4. Produce the documentation required to build the process.

"Text book" process design is commonly broken down into the following stages:

1 Problem Definition

2 Process Synthesis

(Multiple solutions are generated and discarded as quickly as possible to produce a small number of favourable solutions that are taken to more detail)

3 Process Design

(One or two most favoured solutions are developed in enough detail that reasonable financial analysis can be performed, safety and environmental issues can be identified and their risk understood.)

4 Process Analysis

(In this stage optimization of the conditions or equipment will be performed.)

Experience suggests that the steps of process design are intrinsically linked to the phases of how projects in the chemical process industry are executed, and to a smaller degree, the opposite is true. The rest of this paper aims to document those phases, and the products of design that chemical engineers are often involved in.

The following phases of a project are often used, with smaller projects combining some of the stages. The names may be different between companies but for the sake of simplicity we shall refer to them as:

Front End 1 

Front End 2 

Front End 3 

Detailed Design 

Construction 

Start-up

As will be discussed, the design progressively provides not only more detail about the facility so that it may be built and operated, but equally importantly, it provides progressively more accurate estimates of its capital, operating costs, and business risk for business planning purposes. Some steps have a strong emphasis on technical design, some provide essential quality control, others prioritize costs and project management, and some focus more on societal impact. All are elements of the “process design process.” At the end of each of the first four stages, an opportunity is provided for the business team to review the financial/project risk or the changed business environment, and a decision is made to either proceed, delay, or cancel the project.

02 化学工艺设计的步骤

和其他工程设计问题一样，化学工艺设计的目标是以最小的努力成本排除不理想的方案。这通常会采用一种迭代的设计方法，从初步粗略的方案开始，逐步细化，直到找到最优方案。在设计过程中，经济可行性是关键决策工具之一，生成有助于进行经济分析的设计信息是所有方法的重要部分。设计过程的目标如下：

目标 1. 以最小的努力排除不理想的方案。

目标 2. 进行财务估算。

目标 3. 评估过程对社会和环境的风险。

目标 4. 准备构建过程所需的文档。

「教科书」中的工艺设计通常分为以下几个阶段：

1. 问题定义

2. 过程合成（尽快生成和淘汰多个方案，以选出少数几个有前景的方案进行详细研究）

3. 工艺设计（展开一到两个最有前景的方案，以便进行财务分析，识别安全和环境问题并评估其风险）

4. 过程分析（优化条件或设备）

经验表明，工艺设计的步骤与化学过程工业中项目执行的阶段密切相关，反之亦然。本文接下来将记录这些阶段，以及化学工程师们常常参与的设计产品。

项目通常分为几个阶段，小型项目可能会合并一些阶段。虽然不同公司可能会使用不同的名称，但为了简单起见，我们将这些阶段称为：

前端 1

前端 2

前端 3

详细设计建设启动设计过程不仅逐步提供了设施建设和运营的细节，还逐步提供了更准确的资本、运营成本和业务风险估算，这对业务规划非常重要。一些步骤侧重于技术设计，一些提供基本的质量控制，另一些则优先考虑成本和项目管理，还有一些关注社会影响。这些都是「工艺设计」的组成部分。在前四个阶段结束时，业务团队会有机会审查财务/项目风险或变化的业务环境，并决定是继续、推迟还是取消项目。

Front End 1

Depending on the nature of a project, there is a wide range in the amount of available initial information. If the project is a duplication of, or similar to a previous project, then the core process is probably well defined but the interfaces (conditioning of inputs, provision of utility services, storage, (un)loading, etc.) are less so. If the project will be dealing with a new product, then much less information would be available. Regardless, this stage begins with a statement of business objectives and possibly some general information about the actual chemical or product that will be produced, and/or the feedstock that is available.

A thorough analysis of the opportunity and its constraints is usually documented in something called “Basic Data”. The Basic Data remains a living document until the point where a process flow diagram and the heat and material balance (discussed later) are finalized. Once considered complete, the Basic Data is said to be ‘frozen’ and provides the guidance to all of the designers throughout the life of the project.

The first process design step is to generate a series of possible solutions to the problem. The most simplistic representation of a process begins with a block flow diagram, which is distinguished by the fact that no real equipment is required to be documented. A simplistic example is below:

Figure 2. Block Flow Diagram

In a chemical process, the inputs and outputs are usually chemicals, and the modification step is usually some molecular change or bulk property change that takes place (e.g. a separation, a reaction, or a change in heat, size, etc.). The above diagram does not provide much more information than allowing the comparison in costs between raw materials and products. It does allow for a first pass at eliminating some of the possible solutions, for instance, where the inputs are more costly than the outputs.

How the chemical engineer “invents” or synthesizes these alternatives (which are often called the process topography) is an interesting topic. Historically, creative thinking and experience are used,. but the opportunity to use the product designer’s toolkit such as TRIZ, brainstorming, creative problem solving, and others are all possibilities deserving of some consideration. An excellent general purpose reference text dealing with creating the process topography is Analysis, Synthesis, and Design of Chemical Processes [1].

A number of processes require a chemical reaction as part of the modification step(s). The choice of the reaction pathway often significantly affects the overall commercial, safety, and environmental aspects of the process, so it makes sense to show the major alternatives in a tree format with the reactions at the top.

Figure 3. Synthesis Tree Diagram

The possibility of using a continuous or batch process should also be explored at this point.

One technique in process design is described in the book Products & Process Design Principles [2]. They paraphrase the text from Process Synthesis [3] and describe the following steps:

Table 1. Process Synthesis Steps

| Synthesis Step | Process Operations |
| --- | --- |
| 1 Eliminate differences in molecular types | Chemical Reactions |
| 2 Distribute the chemicals by matching sources and sinks  | Mixing |
| 3 Eliminate differences in composition | Separation |
| 4 Eliminate differences in temperature, pressure and phase | Temperature, pressure, and phase change |
| 5 Integrate tasks; that is, combine operations into unit processes and decide between continuous and batch processing | - |

When multiple solutions remain, or if one must be carried to financial analysis, the next step in the design is to produce a model of the process. This model is documented in the format of a “process flow diagram” (PFD) along with accompanying heat and material balances (for discussion purposes, further reference to the PFD will also include a heat and material balance). The PFD provides the first glimpse at what equipment will have to be purchased, and what utilities or additional chemicals will be required to make the process work. A variety of software tools are available for accomplishing the task, such as Unisim, HYSYS, Aspen, and PRO II., but a common spreadsheet style computer program are also necessary to do the required process modelling.

The Process Flow diagram shows the order of the Unit Operations (the equipment) and any recycle streams. What really distinguishes the PFD from the Block Flow Diagram is that all the flows, temperatures, pressures, etc., that enter, or exit a piece of equipment, are defined. This information largely specifies the required performance of the equipment. However, the process flow diagram is not a perfect representation of what the real life process will look like. Similar to the Block Flow diagram, the PFD, like all models, may contain many simplifications. In particular, the PFD does not typically include effects such as gravity, or pressure drop through equipment. Similarly, the PFD may illustrate a single operation that will require two pieces of equipment, or it may show an operation (e.g. a mixer) which probably has no equivalent piece of equipment. In short, judicious engineering judgment must be used to translate the process flow diagram into an actual working process that will be documented by the Piping and Instrumentation Diagram (P&ID). Despite the simplifications or assumptions, there is wealth of information provided by the PFD and material balance, such as the phase (i.e. vapour or liquid, 2 phase), flow rate, the temperature, the pressure, and the molecular compositions that enter and exit the individual operations. In addition, in the case of a distillation column, the same information is also available for the tray to tray internal column operation. A short excerpt of the type of information available from a commercial simulator package (UNISIM ) is shown below:

Figure 5. Simulator Information Example

Not surprisingly, the PFD and the material balance are closely guarded secrets by most corporations.

At the stage in a project where the PFD has been generated, a majority of the future plant costs and safety/environmental risks are locked in. A Process Hazards Review sets the direction of subsequent reviews and, which addresses the major hazards of the chemicals and operating conditions, is performed. The PFD becomes a pivotal document in determining the economics of any particular process. Usually, with some minor additional engineering, and with the selection of proper materials of construction enables a reasonably accurate financial analysis (+/- 30% of the capital costs) can be performed, which includes the raw materials, the utilities and the plant capital costs. This provides a perfect opportunity to eliminate all but a very few of the possible solutions. It would be common to end this phase with a business review of the selected options. The documents most likely to be discussed at such a review would be the capital cost estimate, the overall project financials and risk (NPV, IRR, etc.), a project schedule, and a preliminary analysis of the process, environmental, or technical risks that might impact the viability of the project. Should the review be favourable, the project moves on to the next project stage of engineering.

前端 1

根据项目的性质，初始信息量可能会有所不同。如果是重复或类似于以前的项目，那么核心过程可能已经定义得比较清楚，但接口（如输入调节、公用服务提供、存储、装卸等）可能还不明确。如果是新产品项目，那么可用的信息会少得多。不管怎样，这个阶段开始时会有一个业务目标声明，并且可能会提供一些关于将要生产的化学品或产品以及可用原料的一般信息。

对机会及其限制的全面分析通常记录在一个称为「基础数据」的文件中。在流程图和热物质平衡图（稍后讨论）最终确定之前，基础数据始终是一个动态更新的文档。一旦确定完成，基础数据就会「冻结」下来，并在项目的整个生命周期内为所有设计人员提供指导。

工艺设计的第一步是生成一系列可能的解决方案。最简单的工艺表示形式是方框流程图，其特点是无需记录任何实际设备。下面是一个简单的例子：

图 2：方框流程图在化学工艺中，输入和输出通常是化学品，修改步骤通常涉及分子变化或体积性质变化（例如分离、反应或热量、体积变化等）。上面的图表主要用于比较原材料和产品的成本，并不提供更多信息。不过，它确实允许我们初步筛选一些可能的解决方案，例如那些输入成本高于输出的情况。

化学工程师如何「发明」或合成这些替代方案（通常称为工艺地形）是一个有趣的话题。历史上，创造性思维和经验起到了关键作用，不过使用产品设计工具箱（如 TRIZ、头脑风暴和创造性问题解决）也是值得考虑的方法。一本优秀的通用参考书是《化学工艺的分析、综合与设计》 [1] 。

许多过程在其改造步骤中需要进行化学反应。选择不同的反应路径往往会显著影响整个过程在商业、安全和环境方面的表现。因此，用树状图展示主要的反应路径选择是有意义的，并将反应路径放在顶端。

图 3：合成树状图在这个阶段，还应该探讨使用连续工艺还是批量工艺的可能性。

在《产品与工艺设计原理》一书中描述了一种工艺设计技术 [2]。他们引用了《工艺合成》中的文本 [3] 并描述了以下步骤：

表 1：工艺合成步骤

| 合成步骤 | 工艺操作 |
| --- | --- |
| 1 消除分子类型的差异 | 化学反应 |
| 2 通过匹配源和汇进行化学物质分配 | 混合 |
| 3 消除成分的差异 | 分离 |
| 4 消除温度、压力和相态的差异 | 温度、压力和相态变化 |
| 5 整合任务，即将多个操作合并为单一过程，并在连续和批量处理之间做出选择 | - |

当存在多个解决方案，或者需要进行财务分析时，设计的下一步是生成一个工艺模型。这个模型会以「工艺流程图」(PFD）的格式记录，并附有热量和物料平衡（在后续讨论中提到 PFD 时也包括热量和物料平衡）。PFD 首次展示了需要哪些设备，以及为了使过程正常运行所需的公用设施或额外化学品。许多软件工具可以用于完成这项任务，例如 Unisim、HYSYS、Aspen 和 PRO II，但常见的电子表格样式计算机程序也是进行必要工艺建模的必需工具。

工艺流程图展示了单元操作（设备）的顺序以及任何回收流的路径。与方块流程图不同的是，工艺流程图详细标明了进入或退出每个设备的流量、温度、压力等参数。这些信息在很大程度上决定了设备所需的性能。然而，工艺流程图并不能完全反映实际的工艺过程。与方块流程图一样，工艺流程图作为模型，往往包含许多简化。例如，它通常不会包括重力的影响或设备内部的压降。此外，工艺流程图可能会用一台设备来表示实际需要两台设备完成的操作，或者展示一些可能并不需要具体设备的操作（例如混合器）。因此，需要通过明智的工程判断将工艺流程图转化为实际可行的工艺，这一过程会在管道和仪表图（P&ID）中详细记录。尽管存在简化和假设，工艺流程图和物料平衡依然提供了丰富的信息，例如物料的相态（气相或液相、两相）、流量、温度、压力和分子组成等。此外，对于蒸馏塔，同样的信息也适用于塔内各个塔盘之间的操作。下面是商业模拟器包（UNISIM）提供的信息示例：

图 5：模拟器信息示例不出所料，大多数公司都会严格保密其工艺流程图和物料平衡数据。

在项目生成工艺流程图（PFD）的阶段，大多数未来工厂的成本和安全 / 环境风险已经锁定。工艺危险评审（Process Hazards Review）定下了后续评审的基调，并识别出化学品和操作条件的主要危害。PFD 成为评估任何特定工艺经济性的重要文件。通常，通过一些小的额外工程，再加上选择合适的建造材料，可以进行较为准确的财务分析（资本成本的 +/- 30%），其中包括原材料、公共设施和工厂资本成本。这是一个理想的机会，可以淘汰大多数可能的解决方案。通常在这一阶段结束时，会对选定的方案进行业务审查。在这种审查中，最有可能讨论的文件包括资本成本估算、整体项目财务和风险（NPV, IRR 等)、项目进度以及可能影响项目可行性的工艺、环境或技术风险的初步分析。如果评审结果良好，项目将进入下一个工程阶段。

Front End2

For small or simple projects, this step is likely to merge with either the previous or the next step. The objective of this step is to further define the equipment and to begin to define other ancillary costs for the purpose of preparing a more accurate capital cost estimate and financial analysis.

The previous stage approved the go-ahead for further analysis. Therefore, there are still some unknowns. There are a multitude of questions that may need to be answered before a better design of the plant can be produced. Many of these questions are a result of simplifications or assumptions that have resulted during the process flow diagram stage. Often the unknowns are in the technology and can not be resolved without running the plant. This would be a suitable time to build a prototype (pilot plant), or run test work on an existing process to resolve issues, such as side reactions, that might build up in the process or cause premature failure due to corrosion, or more simply to confirm the kinetics for reactor sizing. A final material balance may be prepared based on the input from the pilot plant or test work. Further design may proceed either in parallel with the pilot plant or iteratively with its design and operation. When the PFD/material balance is deemed to have no further issues that must be resolved, the next step is to prepare the Piping and Instrumentation Diagrams (P&ID’s).

P&ID’s are key to any further design. These drawings describe how the plant will look and operate better than any single other document. It is at their generation that all other engineering disciplines (electrical, instrumentation, civil, mechanical, piping, HVAC, fire protection) can begin their preliminary design. Now the accuracy of the cost estimate is notably improved because reasonably accurate estimates of material quantities can be developed.

The P&ID is developed in stages and remains a living document until construction begins. At this stage in the project, all the equipment (including spares), the instrumentation, and the piping will be shown. Depending on the accuracy of the estimate that is intended to be developed, the pipe codes, insulation, and requirements for tracing will also be shown. (Alternately, these items may be left until stage 3 or detailed design). Since this is still a preliminary stage of design, if there is an existing plant or parts that are identical, the P&ID’s may be merely copied. Extensive detail is added in later stages of design and the final version of the P&ID’s is ready only prior to construction.

The first draft of the P&ID’s is an opportunity to review the design with a variety of stakeholders (operators, maintenance people, plant engineering, etc.) and a thorough review of the drawings is well worth the time commitment to avoid changes in the construction or start-up phase.

Figure 6. Early Stage P&ID Example

Equipment data sheets are usually the next item to be developed. The purpose of the Data Sheets, as they are often called, is to provide sufficient information in order to be sent to vendors for firm quotes. The data sheets are usually initiated by process engineers using information in the heat and material balance, along with standard engineering calculations and guidance from either standards or codes. Basic data or company engineering standards will likely supplement details of the equipment design. Mechanical and/or electrical and instrument engineers provide further detail to the data sheet and usually produce a specification ready for quotation by vendors. In all likelihood, at this stage, only the major equipment that requires quotes (or must be ordered very early in the project schedule) will be developed. Prices for minor pieces of equipment may be obtained from recent projects or estimated by the design team.

Given a P&ID and a set of equipment data sheets, a reasonable attempt at the equipment layout can begin. This starts with a plan view and could possibly extend to elevations or a concept 3D model. A model would not normally be expected at this stage of the design and certainly a detailed one would be rare. A follow-up to the initial Process Hazards Review that includes some analysis of the information contained on the P&ID’s would also be performed.

Since all utilities should be defined at this stage. a thorough analysis of existing site infrastructure versus that needed by the project can be performed, and additional offsite requirements may be added to the project estimate (e.g. steam plants, electrical substations or cogen units, compressed air systems, backup generators, etc.). The remaining plant costs such as loading, unloading, raw material and product storage, cooling and fire water, waste treatment facilities, control rooms, laboratories, maintenance shops, and offices, must be reviewed and included in the capital estimate.

The P&ID affords the first opportunity for the controls group to determine the cost of computer control hardware, control room requirements and to prepare a quantity estimate of the overall control hardware required for operating the plant.

Although it requires additional engineering costs, this is the time where sufficient design detail is defined that a serious critique of the environmental and safety issues, technical issues and operating/capital costs can and should be performed. If necessary, significant changes to the design can be implemented at this point with little impact to the overall cost of the project. Later in the project, significant changes are so costly to implement (due either to schedule extensions, reengineering, or reconstruction costs) that it may not be feasible to make them. Thus, from this point onwards, a change policy is often enforced to ensure all costs are properly considered before a deviation from the original design is approved.

All relevant information is assembled into a “Scope of Work” document. The information contained within this document should allow for a cost estimate in the plus/minus 10 - 20% range, which could be sufficient to make an informed decision to either halt the project, recycle the design with updated business criteria (i.e. reduce the capital cost, have the plant produce a different product mix etc.), or give it a very high probability of proceeding through the further stages of development (which are quite costly in terms of engineering expense). This decision is officially not made until the Front End 3 stage, but in reality, the business team’s decisions are usually made at this point. Because of this, some equipment that has long delivery times may be identified, and detailed engineering specifications sufficient for their purchase are prepared.

前端阶段 2

对于小型或简单项目，这一步可能会与前一步或后一步合并。该步骤的目的是进一步定义设备，并开始确定其他辅助成本，以便准备更为准确的资本成本估算和财务分析。

前一阶段已经批准了进一步的分析工作。因此，现在仍然有一些未知的问题需要解决。为了设计出更好的工厂，我们需要解答许多问题。这些问题大多是因为在流程图阶段的简化或假设导致的。通常，技术上的未知问题需要通过实际运行工厂才能解决。此时，可以考虑建立一个原型工厂（试验工厂），或者在现有的过程中进行测试，以解决可能出现的副反应或因腐蚀导致的早期失效，或者简单地确认反应器的动力学参数。基于试验工厂或测试工作得到的数据，可以准备最终的物料平衡表。之后，可以与试验工厂的设计和运行同步或迭代地进行进一步的设计。当确定流程图（PFD）和物料平衡表上没有需要解决的问题时，下一步就是准备管道和仪表图（P&ID）。

P&ID 对任何进一步的设计都是至关重要的。这些图纸比其他任何单一文件都更能详细描述工厂的外观和运行情况。在生成 P&ID 时，各个工程学科（如电气、仪表、土木、机械、管道、暖通空调和消防保护）可以开始他们的初步设计。现在，由于可以估算出相对准确的材料数量，成本估算的准确性也显著提高。

P&ID（管道和仪表流程图）是分阶段开发的，并且在施工开始前始终是一个动态文档。在项目的这个阶段，所有设备（包括备件）、仪表和管道都会显示出来。如果需要更高的估算准确度，还会标出管道代码、绝缘和追踪要求。（或者，这些项目可以留到第 3 阶段或详细设计阶段）。由于这仍然是设计的初步阶段，如果有现有的相同工厂或部分，P&ID 可能只是简单地复制。在设计的后期阶段会添加详细信息，P&ID 的最终版本会在施工前准备好。

P&ID 的初稿是一个与各种利益相关者（如操作员、维护人员和工厂工程师等）一起审查设计的机会。彻底审查图纸非常值得花时间，以避免在施工或启动阶段进行更改。

图 6：早期阶段 P&ID 示例接下来通常会开发设备数据表。数据表的目的是提供足够的信息，以便发送给供应商获取正式报价。数据表通常由工艺工程师根据热量和物料平衡中的信息，结合标准工程计算和规范指导来编制。基本数据或公司工程标准可能会补充设备设计细节。机械和电气及仪表工程师会为数据表提供进一步的细节，最终生成供应商报价所需的规格。在这个阶段，通常只开发需要报价或必须在项目早期订购的主要设备。小型设备的价格可以从最近的项目中获取或由设计团队估算。

给定 P&ID（管道与仪表流程图）和一组设备数据表后，就可以开始进行设备布局了。首先需要绘制平面图，接着可能会扩展到立面图或概念性的 3D 模型。不过，在这个设计阶段，通常不需要模型，更不用说详细的模型了。接下来，还需要对初步的过程危险评审进行跟进，分析 P&ID 上的信息。

由于这个阶段已经定义了所有公用设施，因此可以详细分析现有场地的基础设施与项目需求之间的差距，并将额外的场外需求加入项目估算中，例如蒸汽厂、电力变电站或联合发电单元、压缩空气系统、备用发电机等。其他工厂成本，如装载与卸载、原材料和产品储存、冷却和消防水、废水处理设施、控制室、实验室、维修车间和办公室等，也需要进行审查并纳入资本估算。

P&ID 还首次为控制组提供了机会，以确定计算机控制硬件的成本、控制室需求，并估算工厂操作所需的整体控制硬件数量。

尽管需要额外的工程成本，但在这个阶段已经有足够的设计细节，这时可以对环境和安全问题、技术问题以及运营和资本成本进行详细评估。如果需要，此时可以对设计进行重大更改，而不会对项目总成本产生太大影响。在项目后期，进行重大更改的成本非常高（可能由于进度延期、重新设计或重建成本），以至于难以实现。因此，从现在开始，通常会实行变更政策，确保在偏离原始设计之前，所有成本都得到充分考虑。

所有相关信息都会汇总到一份「工作范围」文件中。该文件中的信息应当允许成本估算在正负 10% 到 20% 的范围内，这样可以帮助做出是否停止项目、根据更新的业务标准调整设计（例如减少资本成本或改变工厂的产品组合）或高概率推进项目至下一发展阶段的明智决策（此阶段的工程费用非常高）。虽然这一决定在正式上是到前端 3 阶段才做出，但实际上，业务团队通常会在此时做出决定。因为这样，一些交货时间较长的设备会被识别出来，并为其采购准备详细的工程规格。

Front End 3 - Construction Cost Estimate

Approval to proceed with this stage is essentially a commitment to begin spending capital money on the project. Many of the design documents are considered to be capital for tax depreciation, and if it’s deemed highly advantageous, some long lead items that were identified in the previous phase are ordered.

The objective of this phase of the project is to produce a cost estimate with +/- 5 to 10% accuracy. In order to accomplish this level of accuracy, material requirements or “take offs” (eg. tons of concrete, ft of cable, ft of piping. etc.), and man hours for installation must be generated. Modern 3D plant modeling software is database driven and produces the necessary material take offs for the piping and civil engineering groups. It would be common to produce a rough 3D model, complete with preliminary piping, at this stage. Some of the structural analysis would also be completed. The process engineer will have to provide some reasonably accurate line sizes as input to the piping model. Similarly, weights of equipment and sizes must be available for the structural group.

To produce the 3D piping model, P&ID’s and quality control / design tools called the “piping line list” and the “application index” must be generated. The Piping Line List and the Application Index document every pipe in a plant, and list the design pressures, temperatures, materials of construction, and other critical properties. All three of these supporting documents are usually submitted to pressure vessel/piping regulatory agencies during the detailed design or construction phase.

The 3D plant modeling software removes the additional step of creating isometric drawings, while at the same time integrates other disciplines design work in a way that flags interferences (e.g. between steelwork and piping) from occurring. Typically, the 3D models are not fully completed until the Detailed Design Phase. Since the piping material take offs are automatically generated, the model must be completed to a reasonable level of accuracy for the purpose of preparing the capital estimate.

Process Hazard Reviews based on the documentation provided to date are performed to ensure adequate levels of protection against possible unexpected events, and that there are no significant unknowns that could affect the estimate's accuracy.

Normally a preliminary "constructability review" is performed, which provides valuable insight into the plant design and schedule to ensure the minimization of costs during the construction phase. One example of this would be the coordination of the civil/structural installation schedule with the equipment deliveries to minimize the size, number and duration of crane rentals.

Significant legal documentation such as environmental permits might be started in this phase, but they are not usually submitted for approval until all design details are complete. All the above documents, including a schedule for completing the project, are added to the Scope of Work document package.

A revised financial estimate for the project is generated, and is then compared to the cost estimate created in Front End II. Any substantial difference will be carefully scrutinized and a final financial analysis for economic viability is performed. Using all of this information, a business review cycle is undertaken, culminating in the decision to proceed, delay/recycle or cancel the project.

前端 3 - 建设成本估算

批准进入这一阶段实际上是承诺开始在项目上投入资本资金。许多设计文件被视为税收折旧的资本，如果被认为非常有利，一些在前一阶段确定的长交期项目将会被订购。

该项目阶段的目标是生成一个成本误差在 +/- 5% 至 10% 之间的估算。为了达到这一精度水平，需要生成材料需求清单（例如，混凝土的吨数、电缆的长度、管道的长度等）以及安装所需的工时。现代 3D 工厂建模软件依赖数据库驱动，为管道和土木工程组生成必要的材料清单。在这一阶段，通常会生成一个包含初步管道布置的粗略 3D 模型。一些结构分析工作也会在此阶段完成。工艺工程师需要提供较为准确的管道尺寸作为管道模型的输入。同样，设备的重量和尺寸信息也必须提供给结构组。

为了生成 3D 管道模型，必须生成 P&ID（管道与仪表图）和称为「管道管线清单」和「应用索引」的质量控制/设计工具。管道管线清单和应用索引记录了工厂中每根管道的设计压力、温度、构造材料和其他关键属性。这三份支持文件通常在详细设计或施工阶段提交给压力容器/管道监管机构。

3D 工厂建模软件不仅消除了创建等轴测图的额外步骤，还能集成其他学科的设计工作，从而标记出设计冲突（例如钢结构和管道之间的冲突）。通常，3D 模型要到详细设计阶段才会完全完成。由于管道材料清单是自动生成的，因此模型需要达到一个合理的精度水平，以便准备资本估算。

根据现有文档进行的过程危险评审，旨在确保对可能的意外事件有足够的保护，并且没有影响估算准确性的重大未知因素。

通常会进行初步的「可施工性评审」，这能为工厂设计和进度提供宝贵的见解，以确保在施工阶段将成本降到最低。例如，协调土建与结构安装计划和设备交付时间，以减少起重机租赁的规模、数量和持续时间。

重大法律文件，如环境许可证，可能在这一阶段开始准备，但通常要等到所有设计细节完成后才提交审批。所有上述文件，包括项目完成的时间表，都会添加到工作范围文件包中。

在这一阶段，会生成修订后的项目财务估算，并将其与前端 II 阶段创建的成本估算进行比较。任何重大差异都会被仔细审查，并进行最终的经济可行性分析。利用所有这些信息，进行业务审查，最终决定是推进、延期/重新审核还是取消项目。

Detailed Design

The detailed design phase produces information packages that describe the plant in sufficient detail for construction to begin. Usually the initial civil engineering begins as early in this phase as possible. An estimate is also produced but its purpose is to control the construction phase and ensure there are no omissions from the Front End 3 phase, rather than to provide significant additional financial analysis. The contracts to build the equipment are issued in this phase, with the expectation of using the detailed engineering drawings from the vendors to complete the piping, electrical and instrumentation design.

Upon receipt of the construction bids, a final review of the costs is completed and approval by the owner, and the order to proceed with construction, would be given.

Piping design is usually completed through the use of 3D models. Detailed reviews of the facility are carried out with the internal stakeholders (operations, maintenance, and engineering) to provide feedback. Isometrics drawings can now be prepared from the 3D model for inclusion into the piping construction packages. Process designers must check that any assumptions made about the piping during equipment design are in fact true. They must also finalize the relief valve sizing from the isometric drawings produced from the 3D models. Site preparation and initial civil work can begin if funds have been approved (typical of a fast track project).

An important consideration is that the environmental legislative groups normally require completed design documents prior to their review. Their approval is required prior to the beginning of construction and their review of the project can take substantial periods of time. Therefore, finalizing any documents required for their review is given priority so as to avoid construction delays.

When a P&ID, a material balance, and if possible, the 3D model are available, further Process Hazards Reviews are completed to ensure all hazards have been identified and adequate levels of protection are provided. This will ensure the risks are acceptable, hopefully with minimal impact on the design, costs and schedule.

A “constructability review” will occur in this phase in order to ensure the design is optimized for cost effectiveness.

详细设计

详细设计阶段会生成描述工厂详细信息的文档包，以便开始施工。通常，初步土木工程尽可能早地在这一阶段开始。还会生成一个估算，但其目的是控制施工阶段，并确保没有遗漏前端 III 阶段的内容，而不是进行额外的详细财务分析。在这一阶段，设备建造合同也会发布，期望使用供应商提供的详细工程图纸来完成管道、电气和仪表设计。

在收到建筑投标后，将进行最终的成本审查，并在业主批准后下达施工命令。

管道设计通常通过使用 3D 模型来完成。与内部利益相关者（运营、维护和工程）进行详细的设施审查，以便提供反馈。然后可以从 3D 模型中生成管道等距图，并纳入管道施工包。工艺设计师必须核实在设备设计过程中对管道的假设是否正确，还需要根据 3D 模型生成的等距图最终确定泄压阀的尺寸。如果资金已经获批（这在快速推进项目中很常见），则可以开始场地准备和初步土建工作。

一个需要注意的重要问题是，环境立法机构通常要求在审查之前完成设计文件。施工开始前必须获得他们的批准，而他们对项目的审查可能需要较长时间。因此，优先完成需要他们审查的文件，以避免施工延误。

当 P&ID（流程和仪表图)、物料平衡以及（如果可能的话）3D 模型可用时，将进行进一步的工艺危险评估，以确保所有危险都已被识别并提供了足够的保护。这将确保风险在可接受范围内，并希望对设计、成本和进度的影响最小。

在此阶段，还将进行「施工可行性审查」，以确保设计在成本效益上是优化的。

Construciton

As the names implies, this phase involves the actual construction of the plant. In fast track projects, some of the site preparation, including items such as building foundations and some of the building steel will be installed in the detailed design phase. However, the majority of the craft labour will occur in this step. The process engineer is not normally significantly involved in this stage.

When construction is complete, a final process hazards review of the facility is completed to ensure that all recommendations previously made in safety reviews have been implemented, and that no additional hazards are present as a result of the construction. Prior to Commissioning and Start-up, the process engineers contribute to the writing of operating procedures, which, in fact, is the “user manual” for the plant.

Given the complexity of a chemical process plant, it is fairly common to have some minor glitches during start-up. Typical examples would be motors turning in the wrong direction and infant mortalities in the electronics. However, more significant problems may appear due to inadequate information in the design (e.g. phase separations, or unexpected physical properties) Process design engineers are usually on hand to ensure the intent of the design is met, and to check performance of the plant against expectations as described in the Basic Data (the document that was initiated in the Front End 1 phase). At this time, operating procedures may be rewritten as a more complete picture of how the plant will perform becomes clear.

Once the plant has met functionality requirements, it is turned over to operators employed by the owners of the facility. The final phase is a wrap up session to discuss the overall project, with the intended outcome being “lessons learned” that can be applied to the next project.

施工

正如其名，这个阶段涉及工厂的实际建设。在快速推进的项目中，一些现场准备工作，比如建筑基础和部分钢结构的安装，会在详细设计阶段进行。然而，大多数的实际施工工作都将在这个阶段完成。工艺工程师通常不会在这一阶段有太多参与。

施工完成后，会进行最终的工艺危害审查，以确保之前安全审查中提出的所有建议都已落实，并且施工过程中没有引入新的危险。在调试和启动之前，工艺工程师会参与编写操作规程，这实际上是工厂的「用户手册」。

由于化工厂的复杂性，启动过程中出现一些小问题是很常见的。典型的例子有电动机转向错误和电子设备的早期故障。然而，由于设计信息不足（例如相分离或意外的物理性质），可能会出现更严重的问题。工艺设计工程师通常会在场，确保设计意图得以实现，并根据前端 1 阶段启动的基本数据文件中描述的预期检查工厂的性能。在这一阶段，随着对工厂性能的全面了解，操作规程可能会重新编写。

一旦工厂达到功能要求，它将移交给业主雇用的操作人员。最后一个阶段是总结会，讨论整个项目，以便在下一个项目中应用「经验教训」。

### 03. Summary Comments

As can be observed from the preceding discussion, there are similarities between product and process design. The level of “design process” similarity undoubtedly depends on many factors, not the least of which is to what kind of “product” the chemical process design is compared to. However, the general progression of the chemical process design, with the ever-growing documentation/specification package, considerations for cost, safety, and regulatory compliance, creative thinking, idea selection, and so on, appears very much like a progressive “concurrent product design” process, where both product and it’s manufacturing process and equipment are developed concurrently by a cross-disciplinary integrated team. Although output and scale may be different, it would reinforce the notion that to a great degree, the “design process” is generic across the field of engineering.

如前所述，产品设计和工艺设计之间存在相似之处。「设计过程」的相似程度无疑取决于许多因素，尤其是将化学工艺设计与哪种「产品」进行比较。然而，化学工艺设计的一般进展，伴随着不断增加的文档 / 规格说明、成本、安全性和法规合规性的考虑、创造性思维和想法选择等，非常像一个逐步发展的「并行产品设计」过程。在这个过程中，产品及其制造过程和设备由跨学科的综合团队同时开发。尽管输出和规模可能不同，但这会加强这样一种观点，即在很大程度上，「设计过程」在工程领域是通用的。

### 04. Acknowledgements

The authors gratefully acknowledge supporting funding from the Natural Science and Engineering Research Council of Canada (NSERC), through their chairs in Design Engineering program.

### 05. References

1 Turton, Baille, Whiting, Shaeiwitz Analysis, Synthesis, and Design of Chemical Processes (2 nd Ed 2003).

2 Seider, Seader, and Lewin Products & Process Design Principles, (2004).

3 Rudd, Powers, and Siirola, Process Synthesis (1973)