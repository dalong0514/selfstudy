# Implementing Smart Factory of Industrie 4.0: An Outlook

Shiyong Wang, Jiafu Wan, Di Li, and Chunhua Zhang

School of Mechanical and Automotive Engineering, South China University of Technology, Guangzhou 510641, China

Correspondence should be addressed to Jiafu Wan; jiafuwan 76@163.com

Received 5 April 2015; Revised 24 April 2015; Accepted 27 April 2015

Academic Editor: Meikang Qiu

Copyright © 2016 Shiyong Wang et al. This is an open access article distributed under the Creative Commons Attribution License, which permits unrestricted use, distribution, and reproduction in any medium, provided the original work is properly cited.

Hindawi Publishing Corporation International Journal of Distributed Sensor Networks Volume 2016, Article ID 3159805

## Abstract

With the application of Internet of Things and services to manufacturing, the fourth stage of industrialization, referred to as Industrie 4.0, is believed to be approaching. For Industrie 4.0 to come true, it is essential to implement the horizontal integration of inter-corporation value network, the end-to-end integration of engineering value chain, and the vertical integration of factory inside.

In this paper, we focus on the vertical integration to implement flexible and reconfigurable smart factory. We first propose a brief framework that incorporates industrial wireless networks, cloud, and fixed or mobile terminals with smart artifacts such as machines, products, and conveyors. Then, we elaborate the operational mechanism from the perspective of control engineering, that is, the smart artifacts form a self-organized system which is assisted with the feedback and coordination blocks that are implemented on the cloud and based on the big data analytics. In addition, we outline the main technical features and beneficial outcomes and present a detailed design scheme. We conclude that the smart factory of Industrie 4.0 is achievable by extensively applying the existing enabling technologies while actively coping with the technical challenges.

## 01. Introduction

Recently, the emerging technologies (e.g., Internet of Things (IoT) [1–3], wireless sensor networks [4, 5], big data [6], cloud computing [7–9], embedded system [10], and mobile Internet [11]) are being introduced into the manufacturing environment, which ushers in a fourth industrial revolution. Consequently, a strategic initiative called「Industrie 4.0」was proposed and was adopted as part of the「High-Tech Strategy 2020 Action Plan」of the German government [12]. The similar strategies were also proposed by other main industrial countries, for example,「Industrial Internet」[13] from USA and「Internet +」[14] from China. The Industrie 4.0 describes a production oriented Cyber-Physical Systems (CPS) [1517] that integrate production facilities, warehousing systems, logistics, and even social requirements to establish the global value creation networks [18].

1『智能工厂设计到的技术：物联网、无限传感器、大数据、云计算、嵌入式系统、移动网络。打造一个网络系统，其集成了生产系统、仓储系统、物料系统和客户需求系统。（2021-01-27）』

In order to preferably implement Industrie 4.0, the following three key features should be considered [12]: 1) horizontal integration through value networks, 2) vertical integration and networked manufacturing systems, and 3) end-to-end digital integration of engineering across the entire value chain. The setting for vertical integration is the factory, so the vertical integration means implementing the smart factory that is highly flexible and reconfigurable. Therefore, the smart factory is believed to be able to produce customized and small-lot products efficiently and profitably.

1『这里谈到智慧工厂的 3 个关键特征：1）价值网的横向集成。2）制造网络和纵向集成。3）贯穿于整个价值链的端到端工程数据集成。2.2 小结里有更详细的阐述。（2021-01-27）』

Prior to the smart manufacturing of Indusrie 4.0, many other advanced manufacturing schemes have already been proposed to overcome the drawbacks of the traditional production lines, for example, the flexible manufacturing and the agile manufacturing. Among these schemes, the multiagent system (MAS) is the most representative [19]. The manufacturing resources are defined as intelligent agents that negotiate with each other to implement dynamical reconfiguration to achieve flexibility. However, it is difficult for the MAS to handle the complexity of manufacturing system, so it still lacks a generally accepted MAS implementation. In our view, the cloud-assisted industrial wireless network (IWN) can suitably support the smart factory by implementing IoT and services [20, 21]. By this means, the smart artifacts can communicate and negotiate with each other through the IWN to implement self-organization, and the massive data can be uploaded to and processed by the cloud that has scalable storage space and powerful computing ability to implement system-wide coordination.

In this article, we mainly focus on constructing a general architecture of the smart factory and exploring the operational mechanism that organizes the involved technical components. The contributions of our work mainly include five aspects. 

First, we propose a smart factory framework to integrate the IWN, cloud, and terminals with the smart shop floor devices such as machines, products, products, and conveyors. 

Second, we propose a macro closed-loop model that describes the operational mechanism of the architecture, that is, the smart shop floor artifacts form a self-organized system, and the big data analytics provides global feedback and coordination. 

Third, we outline the technical features and beneficial outcomes of the smart factory. 

Fourth, we present a prototype design of our smart factory using the existing technologies. 

Finally, we discuss the main technical challenges and suggest the possible solutions.

The rest of this article is organized as follows. In Section 2, the main features of Industrie 4.0 and its enabling technologies are further discussed. In Section 3, we propose the framework and operational mechanism of the smart factory and outline the main technical features and beneficial outcomes. Then, we introduce the detailed design scheme of our application demonstration in Section 4. In Section 5, the technical challenges and possible solutions about implementing the smart factory are presented. Finally, the conclusions and future work are given in Section 6.

## 02. Philosophy of Industrie 4.0

The term Industrie 4.0 means the fourth industrial revolution. It incorporates emerging technical advancement to improve industry so as to deal with some global challenges. In this section, we present the related background, the main features, and the enabling technologies to form a base for our smart factory development.

### 2.1. Background and Purpose

The human society desires a progressive improvement of life quality. The industry has been advancing to keep pace with this kind of requirements. By now, it has experienced three revolutionary stages, that is, three industrial revolutions. The industry can continue to improve people’s living standard by providing customized and high-quality products to consumers and setting up a better work environment for employees.

However, the current production paradigm is not sustainable [22]. On one hand, the industrial production contributes to much of the environmental disruption, such as global climate warming and environmental pollution. On the other hand, it consumes huge plenty of nonrenewable resources, such as petroleum and coal. In addition, the industry suffers an ever shrinking workforce supply because of population aging.

Therefore, the industry needs a radical change and it is the Industrie 4.0 that addresses this change. The core idea of Industrie 4.0 is to use the emerging information technologies to implement IoT and services so that business process and engineering process are deeply integrated making production operate in a flexible, efficient, and green way with constantly high quality and low cost.

1-2『这里对工业 4.0 下了个定义。做一张术语卡片。（2020-01-27）』——已完成

### 2.2. Three Kinds of Integration

![](./res/2021001.png)

Figure 1: Illustration of three kinds of integration and their relationship.

As we know, the main features of Industrie 4.0 include: 1) horizontal integration through value networks to facilitate inter-corporation collaboration, 2) vertical integration of hierarchical subsystems inside a factory to create flexible and reconfigurable manufacturing system, and 3) end-to-end engineering integration across the entire value chain to support product customization. 

Figure 1 depicts the relationship of the three kinds of integration. The horizontal integration of corporations and the vertical integration of factory inside are two bases for the end-to-end integration of engineering process. This is because the product lifecycle comprises several stages that should be performed by different corporations.

Horizontal Integration. One corporation should both compete and cooperate with many other related corporations. By the inter-corporation horizontal integration, related corporations can form an efficient ecosystem. Information, finance, and material can flow fluently among these corporations. Therefore, new value networks as well as business models may emerge.

Vertical Integration. A factory owns several physical and informational subsystems, such as actuator and sensor, control, production management, manufacturing, and corporate planning. It is essential to vertical integration of actuator and sensor signals across different levels right up to the enterprise resource planning (ERP) level to enable a flexible and reconfigurable manufacturing system. By this integration, the smart machines form a self-organized system that can be dynamically reconfigured to adapt to different product types; and the massive information is collected and processed to make the production process transparent.

1『这里的几个关键词：自组织、实时、生产透明。（2021-01-27）』

End-To-End Engineering Integration. In a product-centric value creation process, a chain of activities is involved, such as customer requirement expression, product design and development, production planning, production engineering, production, services, maintenance, and recycle. By integration, a continuous and consistent product model can be reused by every stage. The effect of product design on production and service can be foreseen using the powerful software tool chain so that the customized products are enabled.

1『这里的几个关键词：定制化是结果。（2021-01-27）』

### 2.3. Needed Technologies

Some emerging information technologies, such as IoT, big data, and cloud computing as well as artificial intelligence (AI) technologies (e.g., MAS) are enabling factors of Industrie 4.0. Integrating these technologies with industrial automation, business, and trade is able to achieve a huge improvement of industry. With powerful microprocessors and AI technologies, the products and machines become smart in the sense that they not only have abilities of computing, communication, and control (3C) but also have autonomy and sociality. With the support of industrial networks, these smart artifacts are interconnected with each other and with the Internet. With the cloud computing technology, the server network can be virtualized as a resource pool that can provide scalable computing ability and storage space on demand for big data analytics. With numerous information systems deployed on cloud and smart things connected to the same cloud, a novel world of IoT and services is created.

The IoT and services lays a solid foundation for the three kinds of integration. For example, a network of smart artifacts can reconfigure itself dynamically and provide massive data to the information systems on the cloud. This is actually vertical integration. With data model and powerful software tools deployed on the cloud, the end-to-end integration can also be implemented. The new electronic commerce such as online-to-offline (O2O) starts a new business model which is an example of horizontal integration.

In summary, the Industrie 4.0 aims to cope with personalized needs and global challenges so as to gain competitive strength considering the globalization of markets. To this end, the emerging information technologies should be applied to every aspect of industry to implement three kinds of integration. Then, high-quality and customized products can be available with improved resource efficiency, productivity, and low cost. The Industrie 4.0 is believed to impose a deep effect that is not limited to industry itself but also to lifestyle and the way we work [23].

## 03. Smart Factory Underpinned by IWN and Cloud

The factory is responsible for actually processing raw materials and semifinished products to produce finished products. Within the boundary of a factory, various physical or informational subsystems are involved during production and management. These subsystems are present at different hierarchical levels, for example, the actuator and sensor, control, production management, manufacturing and execution, and corporate planning levels. At present, the information flow is often blocked between subsystems and the continuity and consistency are generally difficult to be guaranteed; and the material flow is along the fixed production lines that lack flexibility.

Therefore, the Industrie 4.0 expects to vertically integrate the hierarchical subsystems to transfer the traditional factory into the highly flexible and reconfigurable manufacturing system, that is, to implement the smart factory. This is essential to support small-lot and customized consumer demands. The smart factory is also a key base to support the other two kinds of integration, that is, the horizontal integration through value networks and the end-to-end digital integration of engineering. In this section, we present a detailed conceptual design of smart factory by constructing a framework, exploring its operational mechanism and concluding its technical features and beneficial outcomes.

### 3.1. System Architecture

![](./res/2021002.png)

Figure 2: A brief framework of the smart factory of Industrie 4.0.

Figure 2 depicts a smart factory framework consisting of four tangible layers, namely, physical resource layer, industrial network layer, cloud layer, and supervision and control terminal layer. The physical resources are implemented as smart things which can communicate with each other through the industrial network. Various information systems (e.g., ERP) exist in the cloud which can collect massive data from the physical resource layer and interact with people through the terminals [24]. Thus, the tangible framework enables a networked world for intangible information to flow freely. This actually forms a CPS where physical artifacts and informational entities are deeply integrated.

Physical Resource Layer. It comprises various kinds of physical artifacts such as smart products, smart machines, smart products, and smart conveyors. These smart artifacts can communicate with each other through the industrial network; and beyond this, they are able to collaborate for achieving a system-wide goal; for example, a group of machines (generally, a subset of available ones) are determined through negotiation to process the sequence of operations required by a product. Thus, the physical artifacts form a self-organized and autonomous manufacturing system based on industrial network and intelligent negotiation mechanism.

Industrial Network Layer. It forms a kind of important infrastructure that not only enables inter-artifact communication but also connects the physical resource layer with the cloud layer. The IWN is superior to the wired network such as industrial Ethernet considering the volatile characteristics of the smart factory caused by, for example, the newly added machines or machine malfunction and the mobile entities such as automated guided vehicles (AGVs) and products. The IWN can accommodate these variations more easily because it can provide more flexible and convenient wireless links. Therefore, the IWN is believed to be mandatory for smart factory.

Cloud Layer. It is another kind of important infrastructure that supports the smart factory. The term cloud is a vivid expression for a network of servers that provides layered services in the form of Infrastructure-as-aService (IaaS), Platform-as-a-Service (PaaS), and Software-as-a-Service (SaaS). With the cloud computing technology, even the Internet can be virtualized as a huge resource pool. Therefore, the cloud provides a very elastic solution for big data application in the sense that both the storage space and computing ability can be scaled on demand. When operated, the smart artifacts may produce massive data, which can be transferred to the cloud through the IWN for information systems to process. The big data analytics then can support system management and optimization including supervision and control.

Supervision and Control Terminal Layer. It links people to the smart factory. With the terminals such as PCs, tablets, and mobile phones, people can access the statistics provided by the cloud, apply a different configuration, or perform maintenance and diagnosis, even remotely through the Internet.

### 3.2. Operational Mechanisms

![](./res/2021003.png)

Figure 3: Operational mechanism of the smart factory of Industrie 4.0.

From the perspective of control engineer, the smart factory can be viewed as a closedloop system, as shown in Figure 3. In the center of the control loop is the network of smart artifacts. The smart artifact has 3C capabilities, and beyond this, it has autonomy and sociality. By autonomy, we mean that the smart artifact makes decisions by itself; no other entities can directly control its behavior. By sociality, we mean that the smart artifacts understand a common set of knowledge and follow a common set of rules for negotiation. Therefore, a society of smart artifacts can yield a highly flexible manufacturing system, that is, a self-organized and reconfigurable system that seems to be humanoid or smart.

1『这里感觉出现了核心的观点，autonomy and sociality，做一张主题卡片。（2021-01-27）』——已完成

Through collaboration, the smart artifacts try to align their behaviors to approach a system-wide goal; but the system performance is generally not optimal. This is because the smart artifacts are myopic that they make decisions based on local information. As to manufacturing, load may not be balanced, efficiency may not be the highest, and deadlocks may occur. The big data analytics block in the feedback channel that lies in the cloud serves to solve this problem. The smart machines communicate their state and process information to the block, and the distributed sensors transfer their sensed data to the block as well. Therefore, the global state of the system can be extracted from the massive realtime system information. Based on the powerful computing ability, the block processes this big data in time to serve two purposes: 1) coordinate the behaviors of the distributed smart artifacts and 2) feedback performance indictors to the self-organized network. By this global optimization, the smart artifacts are affected so that higher performance can be expected.

### 3.3. Technical Features

![](./res/2021004.png)

Figure 4: Illustration of the traditional production line and smart factory production system.

Figure 4 illustrates the difference between the traditional production line and the smart factory production system. The traditional production line aims to produce the single type of products. It generally consists of several machines and a conveyor belt. The conveyor belt is not closed; that is, one end serves as the input and the other end serves as the output, and the machines are deployed along the line. When the unfinished products flow through the line from the input to the output, each machine performs its predetermined part of task. Generally, no redundant machines exist, and the conveyor belt is carefully tailored. The machine has its own independent controller, but the communication between machines is seldom. By contrast, the smart factory production system aims to process multiple types of products. Thus, from the view of the single product type, the machines are redundant. The machines relay on negotiation to reconfigure themselves to adapt to product type variation. The conveyor belt should be closed to support various production routes, so there is not definite input or output.

1『这里 get 到了精髓。1）传统工厂「the machines are deployed along the line」，可以理解为设备是在一条固定的合成路线（流程）上的，智能工厂可以实时调整路线。单个线路上核心设备出现故障，整个生产线就得停，智慧工厂的话就换着走另外一条线。2）可以切换生产不同的产品，类似于多功能车间。2）传统工厂，单个设备、单个单元操作组联锁控制，智慧工厂设备全部联网，共享一个大脑云。（2021-01-27）』

These fundamental differences deliver some key features for the smart factory. We outline these features in Table 1 by comparing with that of traditional factory.

TABLE 1: Technical features of smart factory compared with the traditional factory

| Number | Smart factory production system | Traditional production line |
| --- | --- | --- |
| 1 | Diverse Resources. To produce multiple types of small-lot products, more resources of different types should be able to coexist in the system. | Limited and Predetermined Resources. To build a fixed line for mass production of a special product type, the needed resources are carefully calculated, tailored, and configured to minimize resource redundancy. |
| 2 | Dynamic Routing. When switching between different types of products, the needed resources and the route to link these resources should be reconfigured automatically and on line. | Fixed Routing. The production line is fixed unless manually reconfigured by people with system power down. |
| 3 | Comprehensive Connections. The machines, products, information systems, and people are connected and interact with each other through the high speed network infrastructure. | Shop Floor Control Network. The field buses may be used to connect the controller with its slave stations. But communication among machines is not necessary. |
| 4 | Deep Convergence. The smart factory operates in a networked environment where the IWN and the cloud integrate all the physical artifacts and information systems to form the IoT and services. | Separated Layer. The field devices are separated from the upper information systems. |
| 5 | Self-Organization. The control function distributes to multiple entities. These smart entities negotiate with each other to organize themselves to cope with system dynamics. | Independent Control. Every machine is preprogrammed to perform the assigned functions. Any malfunction of single device will break the full line. |
| 6 | Big Data. The smart artifacts can produce massive data, the high bandwidth network can transfer them, and the cloud can process the big data. | Isolated Information. The machine may record its own process information. But this information is seldom used by others. |

On the other hand, the proposed smart factory production system also has obvious differences with the MAS scheme in the sense that the MAS scheme does not involve cloud and big data. Thus, the MAS scheme is not able to benefit from the big data based feedback and coordination. In addition, the big data enables smart artifacts to form an autonomous architecture, while the existing MAS schemes are generally characterized by hierarchical or mediator architectures. Therefore, the smart factory of Industrie 4.0 assists the self-organized systems such as MAS with the cloud and big data technologies to combine the advantages of the selforganization and central control.

### 3.4. Beneficial Outcomes

The advanced technical features suggest that the smart factory exhibits an attractive and promising production paradigm. It leads to many beneficial outcomes which can cope with the global challenges in the sense that the customized products can be produced effectively, efficiently, and profitably. We discuss some possible merits that the whole society can benefit from. These benefits are also guiding the effort to promote the implementation of the smart factory.

Flexibility. The smart artifacts can be reconfigured automatically to produce multiple types of products. Even new products can be directly ordered to the system. This helps to cope with ever changing market and discerning consumption demands. The self-organization and dynamic reconfiguration also bring robustness in the sense that new machines can join the system in a plug and play way; and the malfunction machines will not affect the system due to the machine redundancy.

Productivity. Compared with the traditional production line, the smart factory can produce small-lot products of different types more efficiently. On one hand, the setup time is minimized when switching between different types of products. On the other hand, as the production process is optimized with the help of big data feedback and coordination, the average manufacturing routes are shrunk and the utilization rate of machines and other resources is improved.

Resource and Energy Efficiency. Based on the big data analytics, we can establish an accurate knowledge of production process and guarantee system with a stable product quality level and the rate of finished products. Thus, the needed raw materials can be determined before production and product redundancy can be minimized. In addition, smart machines operate in more intelligent way that the energy consumption can be reduced consequently. The measures include saving energy during breaks and using more new technologies such as speed-controlled motors.

Transparency. The big data provides real-time, complete, and effective information on every aspect of the smart factory [25, 26]. Based on the big data analytics, we can quantify performance indicators related to machines, products, and system. This enables us to make accurate and effective decisions more quickly. This can also facilitate production plan and accelerate response to market inquiry. When the production ability of the smart factory cannot satisfy a certain product order, the questions about how to improve the system can also be easily answered.

Promoting Integration. The vertical integration of hierarchical subsystems leads to smart factory, which in turn supports horizontal integration through value networks and end-to-end digital integration of engineering. Thus, the smart factory lays a solid foundation for more extensive integration and collaboration, that is, the implementation of Industrie 4.0. Based on this global collaboration network, the consumers, design activities, manufacturing, and logistics can interact above the cloud. This will deliver a sustainable production paradigm, which also has a profound impact on life style, culture, and social organization.

Profitable. We consider the initial investment cost first and then the operational cost. The additional investment mainly refers to the IWN, cloud, and new information systems compared with the traditional production lines. Based on the Moore’s law, the cost of information technologies will constantly decline while the performance constantly improves. For the coming small-lot and customized consummation demands, the operational cost is rather low compared with the fixed production line because of flexibility and resource and energy efficiency. It is pointed out that even one-off items can be produced profitably with the smart factory.

Friendly to Staff. The machines operate automatically by themselves so that no workers need to perform routine tasks. With the assistance of big data analytics, powerful software tools, and more friendly and flexible interface measures, maintenance and diagnosis become much easier. Even people all over the world can work together to perform remote repair work, as the people and machines can interact with each other through the cloud.

## 04. Application Demonstration

The smart factory is a particular implementation of CPS that is based on the extensive and deep application of information technologies to manufacturing. As the needed technologies at least have some preliminary version, some pilot smart factory applications have already been established. This is an important step to promote Industrie 4.0. The key problems can be identified during the integration process, and the benefits can be demonstrated to the society.





At the smart factory prototype of「German Research Centre for Artificial Intelligence (DFKI)」in Kaiserslautern, chemicals giant BASF SE produces fully customized shampoos and liquid soaps [27]. As a test order is placed online, the empty soap bottle that is attached with the radio frequency identification (RFID) tag communicates to production machines what kind of soap, fragrance, bottle cap color, and labeling it requires. Each bottle has the potential to be entirely different from the one next to it on the conveyor belt. The experiment relies on a wireless network through which the machines and products do all the talking, with the only human input coming from the person placing the sample order.

Now, we are developing our smart factory prototype. The main configurations are described as follows.

Figure 5: Illustration of the flexible conveying system of the smart factory.

Raw Products with RFID Tags. The raw products that will be processed by the smart factory are pasted with readable and writeable RFID tags. Before entering the system, the raw product has its attached RFID tag written with process requirements. This information helps to organize machines and configure production route. The content of RFID tag is kept updated during production. The carrier of the product that is equipped with a RFID reader interacts with the product. The carrier then represents the product to communicate with machines.

Robotic Machines. We use a number of 10 six-joint serial robots for loading and unloading operation plus a number of 20 Cartesian robots for machining and testing. The serial robots are from Japanese DENSO corp. with the model VS6577G, and the Cartesian robots are from Chinese Bangkang corp. One serial robot serves two Cartesian robots. The Cartesian robots can be equipped with different manipulators to serve different functions. The serial robots fetch products from conveying system and put the products onto the fixtures of the Cartesian robots and vice versa. The fetching positions of products for the serial robots are marked with sensors. Machine vision technology is also used to position the products.

Conveying System. We are designing and developing a railway like conveying system. A kind of two-meter long linear module and a kind of right-angle arc module are used to assemble multiple interconnected cyclic tracks. Each module has its own smart controller. The AGVs run along these tracks. Each AGV can control its position and velocity independently and prevents collision with the assistance of tracks. The AGV is equipped with a RFID reader so it can read or write to the products’ RFID tags. The AGVs can also communicate with machines on behalf of the products. We illustrate a possible configuration in Figure 5, where there is a storage segment connected to the tracks for recycling the empty AGVs (represented as the green circles).

IWN. We use wireless products from Taiwan MOXA corp. to set up our IWN. This includes AWK-1121 series industrial IEEE 802.11a/b/g wireless clients and NPort W2150A 1-port RS-232/422/485 IEEE 802.11a/b/g wireless device servers. The wireless clients are installed to machines and AGVs, and the servers are distributed uniformly over the conveying system.

Private Cloud. We set up a private cloud with five NF5270 M3 servers from Chinese Inspur Corp. With cloud computing software, the network of servers is virtualized as a super computer for our smart factory platform. Compared with the public cloud solution, the private cloud scheme enables us first-hand experience about cloud computing and big data analytics. We expect this experience to provide us with practical requirements when shifting to the public cloud service.

Large Screen and Small Terminals. We construct a one-meter wide and three-meter long liquid crystal display (LCD) for displaying various kinds of information such as big data analysis results and the virtual reality (VR) model of the smart manufacturing platform. Both iOS and Android based smart phones and Windows or UNIX based PCs can be connected to the cloud through Wi-Fi access points. These mobile and fixed terminals are for supervision and control purpose.

## 05. Technical Challenges and Solutions

We need smart hardware and software to construct the smart factories. These include smart machine controllers, high bandwidth IWN devices, manufacturing related big data analytics software, and the integrated information systems. But prior to the off-the-shelf products, the underlying technical issues should be investigated. Based on the theoretical analysis and development experiences, we identify several challenges and give possible solutions in this section.

### 5.1. Intelligent Decision-Making and Negotiation Mechanism

The smart artifacts are fundamental components of smart factory. While today’s computer numerical control (CNC) machines generally have 3C capabilities, the smart machines should have additional autonomy and sociality capabilities. This means the smart machines can make decisions by themselves instead of being directly instructed, and they can negotiate with each other and with the smart products. Therefore, the autonomy and sociality capabilities are the key enablers for the implementation of a self-organized manufacturing system. The research on MAS that is a branch of AI technology can provide some useful results such as the ontology method and the contract net protocol (CNP) [28]. However, further research is still needed to achieve the autonomous manufacturing system architecture instead of hierarchical or mediator ones.

### 5.2. High Speed IWN Protocols

The IWN is superior to wired network in a manufacturing environment; but the existing IWN standards such as WIA-PA [29] and WirelessHART [30] cannot provide enough bandwidth for heavy communication and high-volume data transfer. The standards such as IEEE 802.11 [31, 32] can provide high bandwidth but not specially designed for industrial applications. The IWN used in automation is different from the ad hoc wireless sensor network (WSN) used in surveillance domains [33, 34]. The QoS other than energy efficiency is more concerned. Maybe the hybrid solution that wireless gateways are wired to form a backbone mesh network is a practical implementation at present.

### 5.3. Manufacturing Specific Big Data and Its Analytics

Big data will deliver big value in the future. The utilization of big data is now feasible with the cloud computing that enables a scalable storage and computing ability. Despite the cloud computing and general big data analytics, we should focus on special features of manufacturing related big data. Questions on which data should be collected, how these data can be collected, how to formulate, what is the meaning and how to analyze should be answered.

Instead of collecting various data and then struggling to think how to use them, the practical beginning may be considering which information can reveal quality and efficiency related factors. For example, as the malfunction machines will reduce product quality and the finished product ratio, the machine state and its operation history should be monitored and analyzed to predict problems so that people can respond in advance. To improve efficiency, we should know the time taken in processing each operation and operation time of each machine. This helps to recognize the performance bottleneck of operations and load unbalance of machines.

### 5.4. System Modeling and Analysis

By the general selforganized theory, the self-organized process may lead to unexpected situations such as chaos [35]. Thus, we need to model self-organized manufacturing system, deduce its dynamical equations, and conclude appropriate control methods. However, the theories on self-organized system are not matured and the complex system research is still a hot topic. The formal methods such as model checking technology may be possible option for modeling and analyzing selforganized manufacturing system [36].

### 5.5. Cyber and Property Security

We cannot place too much emphasis on security aspects. Without security, we dare not bring our smart factories into service. The smart factory suffers bigger security problems than traditional Internet applications [37, 38]. On one hand, we should protect various information on customers, suppliers, commercial strategies, and know-hows. These kinds of information are generally stored in the public cloud instead of enterprises’ private data center. These confidential materials may be disclosed, for example, by hackers, which may cause huge profit loss or even legal disputes. On the other hand, the machines and other physical objects and even people themselves are connected to the cloud. When control mechanism is broken, these objects may operate in a destructive way to cause direct property loss.

Encryption and authorization are generally used in cyber security domain, which will be still useful in smart factory or Industrie 4.0 applications; but these mechanisms are not enough. By now, we do not have a way to create an absolute software system. Even the very famous software is suffering endless loopholes [39]. New mechanisms which are specially designed for smart factory should be developed; and before these come true, some conservative methods may be practical options. For example, the critical information is stored in enterprises’ private cloud and the unsafe operation instructions are reported to people rather than being immediately executed.

### 5.6. Modularized and Flexible Physical Artifacts

When processing a product, distributed decision-making organizes a group of resources together. These resources include equipment for machining or testing and that for conveying. Thus, it is required that these physical artifacts should be able to work together. First of all, the conveying system should be able to transfer products between any two machines. Secondly, functions for automatic positioning, clamping, and programming should be integrated into the system. Therefore, we should develop modularized and smart conveying units that can dynamically reconfigure production routes. The modularized and standalone positioning and clamping units, with smart controllers should also be developed to easily incorporate new machines to the system.

## 06. Conclusions and Future Work

With the emerging information technologies, such as IoT, big data, and cloud computing together with artificial intelligence technologies, we believe the smart factory of Industrie 4.0 can be implemented. The smart machines and products can communicate and negotiate with each other to reconfigure themselves for flexible production of multiple types of products. The massive data can be collected from smart artifacts and transferred to the cloud through the IWN. This enables the system-wide feedback and coordination based on big data analytics to optimize system performance. The above self-organized reconfiguration and big data based feedback and coordination define the framework and operational mechanism of the smart factory.

The smart factory helps to implement the sustainable production mode to cope with the global challenges. It can lead to novel business modes and even affect our lifestyle. Although the implementation of smart factory is still facing some technical challenges, we are walking on the right path by simultaneously applying the existing technologies and promoting technical advancements. With the existing technologies, some application demonstrations have already been built. Therefore, the smart factory and the Industrie 4.0 can be implemented in a progressive way, along with the unstopped technical advancements. In the future, we will continue to develop our prototype design and focus on the key enabling technologies.

## Conflict of Interests

The authors declare that there is no conflict of interests regarding the publication of this paper.

## Acknowledgments

This work was supported in part by the National Key Technology R&D Program of China (no. 2015BAF20B01), the National Natural Science Foundation of China (no. 61262013), the Science and Technology Planning Project of Guangdong Province, China (nos. 2012A010702004 and 2012A090100012), the Fundamental Research Funds for the Central Universities, SCUT (no. 2014ZM0014), and The Open Fund of Guangdong Province Key Laboratory of Precision Equipment and Manufacturing Technology (no. PEMT1303).

## References

[1] F. Tao, Y. Zuo, L. D. Xu, and L. Zhang,「IoT-Based intelligent perception and access of manufacturing resource toward cloud manufacturing,」IEEE Transactions on Industrial Informatics, vol. 10, no. 2, pp. 1547–1557, 2014.

[2] Q. Jing, A. V. Vasilakos, J. Wan, J. Lu, and D. Qiu,「Security of the Internet of Things: perspectives and challenges,」Wireless Networks, vol. 20, no. 8, pp. 2481–2501, 2014.

[3] F. Chen, P. Deng, J. Wan, D. Zhang, A. V. Vasilakos, and X. Rong,「Data mining for the internet of things: literature review and challenges,」International Journal of Distributed Sensor Networks. In press.

[4] M. Qiu, X. Chun, Z. Shao, Q. Zhuge, M. Liu, and E. Sha,「Efficent algorithm of energy minimization for heterogeneous wireless sensor network,」in Embedded and Ubiquitous Computing, vol. 4096 of Lecture Notes in Computer Science, pp. 25–34, Springer, Berlin, Germany, 2006.

[5] M. Qiu and E. Sha,「Energy-aware online algorithm to satisfy sampling rates with guaranteed probability for sensor applications,」in High Performance Computing and Communications, vol. 4782 of Lecture Notes in Computer Science, pp. 156–167, Springer, Berlin, Germany, 2007.

[6] M. Chen, S. Mao, and Y. Liu,「Big data: a survey,」Mobile Networks and Applications, vol. 19, no. 2, pp. 171–209, 2014.

[7] X. Xu,「From cloud computing to cloud manufacturing,」Robotics and Computer-Integrated Manufacturing, vol. 28, no. 1, pp. 75–86, 2012.

[8] Q. Liu, J. Wan, and K. Zhou,「Cloud manufacturing service system for industrial-cluster-oriented application,」Journal of Internet Technology, vol. 15, no. 4, pp. 373–380, 2014.

[9] J. Wan, D. Zhang, Y. Sun, K. Lin, C. Zou, and H. Cai,「VCMIA: a novel architecture for integrating vehicular cyber-physical systems and mobile cloud computing,」Mobile Networks and Applications, vol. 19, no. 2, pp. 153–160, 2014.

[10] J. Wan, D. Li, H. Yan, and P. Zhang,「Fuzzy feedback scheduling algorithm based on central processing unit utilization for a software-based computer numerical control system,」Proceedings of the Institution of Mechanical Engineers, Part B: Journal of Engineering Manufacture, vol. 224, no. 7, pp. 1133–1143, 2010.

[11] F. Soliman and M. A. Youssef,「Internet-based e-commerce and its impact on manufacturing and business operations,」Industrial Management & Data Systems, vol. 103, no. 8-9, pp. 546–552, 2003.

[12] Recommendations for implementing the strategic initiative INDUSTRIE 4.0, 2013, http://www.acatech.de/fileadmin/user upload/Baumstruktur nach Website/Acatech/root/de/Material fuer Sonderseiten/Industrie 4.0/Final report Industrie 4.0 accessible.pdf.

[13] The Industrial Internet Consortium: A Global Nonprofit Partnership of Industry, Government and Academia, 2014, http:// www.iiconsortium.org/about-us.htm.

[14] Premier of the State Council of China and K. Q. Li,「Report on the work of the government,」in Proceedings of the 3rd Session of the 12th National People’s Congress, March 2015.

[15] M. Riedl, H. Zipper, M. Meier, and C. Diedrich,「Cyber-physical systems alter automation architectures,」Annual Reviews in Control, vol. 38, no. 1, pp. 123–133, 2014.

[16] J. Wan, H. Yan, Q. Liu, K. Zhou, R. Lu, and D. Li,「Enabling cyber-physical systems with machine-to-machine technologies,」International Journal of Ad Hoc and Ubiquitous Computing, vol. 13, no. 3-4, pp. 187–196, 2013.

[17] J. Wan, D. Zhang, S. Zhao, L. Yang, and J. Lloret,「Contextaware vehicular cyber-physical systems with cloud support: architecture, challenges, and solutions,」IEEE Communications Magazine, vol. 52, no. 8, pp. 106–113, 2014.

[18] E. M. Frazzon, J. Hartmann, T. Makuschewitz, and B. ScholzReiter,「Towards socio-cyber-physical systems in production networks,」in Proceedings of the 46th CIRP Conference on Manufacturing Systems, pp. 49–54, May 2013.

[19] W. Shen, Q. Hao, H. J. Yoon, and D. H. Norrie,「Applications of agent-based systems in intelligent manufacturing: an updated review,」Advanced Engineering Informatics, vol. 20, no. 4, pp. 415–431, 2006.

[20] R. Drath and A. Horch,「Industrie 4.0: hit or hype?」IEEE Industrial Electronics Magazine, vol. 8, no. 2, pp. 56–58, 2014.

[21] J. Liu, Q. Wang, J. Wan, J. Xiong, and B. Zeng,「Towards key issues of disaster aid based on wireless body area networks,」KSII Transactions on Internet and Information Systems, vol. 7, no. 5, pp. 1014–1035, 2013.

[22] E. Alkaya, M. Bogurcu, F. Ulutas, and G. N. Demirer,「Adaptation to climate change in industry: improving resource efficiency through sustainable production applications,」Water Environment Research, vol. 87, no. 1, pp. 14–25, 2015.

[23] J. Lee, H. A. Kao, and S. Yang,「Service innovation and smart analytics for industry 4.0 and big data environment,」Procedia CIRP, vol. 16, pp. 3–8, 2014.

[24] G. Schuh, M. Pitsch, S. Rudolf, W. Karmann, and M. Sommer,「Modular sensor platform for service-oriented cyber-physical systems in the European tool making industry,」Procedia CIRP, vol. 17, pp. 374–379, 2014.

[25] J. Lee, E. Lapira, B. Bagheri, and H.-A. Kao,「Recent advances and trends in predictive manufacturing systems in big data environment,」Manufacturing Letters, vol. 1, no. 1, pp. 38–41, 2013.

[26] M. Chen, H. Jin, Y. Wen, and V. Leung,「Enabling technologies for future data center networking: a primer,」IEEE Network, vol. 27, no. 4, pp. 8–15, 2013.

[27] C. Alessi,「Germany develops ’smart factories’ to keep an edge,」2014, http://www.marketwatch.com/story/germany-developssmart-factories-to-keep-an-edge-2014-10-27.

[28] R. G. Smith,「The contract net protocol: high level communication and control in a distributed problem solver,」IEEE Transactions on Computers, vol. 29, no. 12, pp. 1104–1113, 1980.

[29] W. Liang, X. Zhang, Y. Xiao, F. Wang, P. Zeng, and H. Yu,「Survey and experiments of WIA-PA specification of industrial wireless network,」Wireless Communications and Mobile Computing, vol. 11, no. 8, pp. 1197–1212, 2011.

[30] J. Song, S. Han, A. K. Mok, D. Chen, M. Lucas, and M. Nixon,「WirelessHART: applying wireless technology in realtime industrial process control,」in Proceedings of the 14th IEEE Real-Time and Embedded Technology and Applications Symposium (RTAS ’08), pp. 377–386, St. Louis, Mo, USA, April 2008.

[31] A. Raniwala and T.-C. Chiueh,「Architecture and algorithms for an IEEE 802.11-based multi-channel wireless mesh network,」in Proceedings of the IEEE 24th Annual Joint Conference of the IEEE Computer and Communications Societies (INFOCOM ’05), vol. 3, pp. 2223–2234, IEEE, March 2005.

[32] M. Chen, J. Wan, S. Gonzalez, X. Liao, and V. C. M. Leung,「A survey of recent developments in home M2M networks,」IEEE Communications Surveys and Tutorials, vol. 16, no. 1, pp. 98–114, 2014.

[33] N. A. Pantazis, S. A. Nikolidakis, and D. D. Vergados,「Energyefficient routing protocols in wireless sensor networks: a survey,」IEEE Communications Surveys & Tutorials, vol. 15, no. 2, pp. 551–591, 2013.

[34] J. Liu, Q. Wang, J. Wan, and J. Xiong,「Towards real-time indoor localization in wireless sensor networks,」in Proceedings of the IEEE 12th International Conference on Computer and Information Technology (CIT ’12), pp. 877–884, Chengdu, China, October 2012.

[35] U. Merry and N. Kassavin, Coping with Uncertainty: Insights from the New Sciences of Chaos, Self-Organization, and Complexity, Praeger Publishers/Greenwood Publishing Group, 1995.

[36] J. Pilecki, M. A. Bednarczyk, and W. Jamroga,「Model checking properties of multi-agent systems with imperfect information and imperfect recall,」in Advances in Intelligent Systems and Computing, vol. 322, pp. 415–426, 2015.

[37] M. Qiu, H. Su, M. Chen, Z. Ming, and L. T. Yang,「Balance of security strength and energy for a PMU monitoring system in smart grid,」IEEE Communications Magazine, vol. 50, no. 5, pp. 142–149, 2012.

[38] M. Qiu, W. Gao, M. Chen, J.-W. Niu, and L. Zhang,「Energy efficient security algorithm for power grid wide area monitoring system,」IEEE Transactions on Smart Grid, vol. 2, no. 4, pp. 715723, 2011.

[39] C. Osborne, Google’s Project Zero Reveals Three Apple OS X Zero-Day Vulnerabilities, 2015, http://www.zdnet.com/article/ googles-project-zero-reveals-three-apple-os-x-zero-day-vulnerabilities/.