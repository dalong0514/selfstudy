# Smart Factory - A Step towards the Next Generation of Manufacturing

Dominik Lucke1 , Carmen Constantinescu1, 2 , Engelbert Westkämper1, 2 Institut für Industrielle Fertigung und Fabrikbetrieb, IFF - Universität Stuttgart, Germany

Fraunhofer-Institut für Produktionstechnik und Automatisierung, IPA - Stuttgart, Germany

January 1, 2008

## Abstract

The Stuttgart Model of adaptive, transformable and virtual factories, already implemented in German basic research performed at the Universität Stuttgart has been extended with a new perspective, the so-called「Smart Factory」. The Smart Factory approach is a new dimension of multi-scale manufacturing by using the state-of-the-art ubiquitous/pervasive computing technologies and tools. The Smart Factory represents a context-sensitive manufacturing environment that can handle turbulences in real-time production using decentralized information and communication structures for an optimum management of production processes. This paper presents our research steps and future work in giving reality to the envisioned Smart Factory at the Universität Stuttgart.

Keywords: Smart Factory; Real-time Factory; Ubiquitous computing

1『这里出现了一个关键词「real-time production」。（2021-01-27）』

## 01. Problem Statement

In recent years manufacturing engineering experienced a dramatic change through different parallel running developments. The globalisation and the wish to produce highly customized products lead to a higher proliferation of variants, shorter product life cycles and closer enterprise networks. The short planning horizons and product life cycles induce the decrease of batch sizes and do therefore require a high dimension of manufacturing flexibility. In order to make the right management decisions, real-time information and the direct realisation of the decisions are indispensable.

Dynamical changes in the factory, caused through internal or external turbulences like a machine breakdown or an order fluctuation in the market, can often not be taken into account and therefore lead to false decisions on different planning levels. Due to complex interactions of the different functions and departments of the factory and their task-oriented specific data formats, the causes of the dynamic changes exponentiate themselves and their consequences for the factory as well. Thus, high flexibility demands are posed to the manufacturing resources, their planning and control [1].

The management control of the complex processes inside and outside of the factory is even today performed through Enterprise Resource Planning (ERP) and Manufacturing Execution Systems (MES) and applications. The increased market turbulences and therefore increased flexibility of manufacturing require complex manufacturing sequences, which are difficult to realise with the today’s solutions. Outdated information in the different information systems are leading directly to problems in planning and production.

The information management is responsible for the allocation of the job and process specific information like NC programs or machine properties, however the material management is responsible for the supply of components. Tool and device systems are additional mobile manufacturing resources to conduct a manufacturing process. The coordination of many heterogeneous subsystems providing all required resources, materials and information at the work place is necessary to ensure a constant resource load. To achieve this synchronization, many different specialized software systems and applications are used, like resource management systems, MES or ERP systems. Any failure in a subsystem would result in a significant reduction of the productivity of the whole system. While a MES plans and controls the manufacturing level, the ERP level plans and controls the synchronization of the subsidiary planning entities. Even the smallest difference between the real and digital saved data, e.g. initiated by a malfunction, leads to planning discrepancies and a miscalculation of the optimal working point.

A parallel development was enabled by the integration of electronic components like microchips or sensors into objects due to their decline of price. This development enables a decentralized control in a more economical way.

## 02. Smart Factory: Definition, Challenges and Enabling Technologies

The design and development of the Smart Factory require as a first step the definition of the concept. Mark Weiser’s vision of the smart environment describes a physical world, which is closely and invisibly interwoven with sensors, actuators, displays and computer elements, which are seamlessly embedded into daily life objects. They are connected with each other by a network [2]. The Mark Weiser’s approach of smart environments is transferred to manufacturing issues. After the development of digital and virtual factories next step in evolution of factories is the fusion of physical and virtual world [3] under a so-called Smart Factory.

### 2.1 Definition

The basic research in the field of Smart Factory at Institute of Industrial Manufacturing and Management (IFF) is performed within the Center of Excellence Nexus (SFB 627) [4]. This interdisciplinary research is funded by the German Research Foundation (DFG). The so-called Smart Factory is defined as a Factory that context-aware assists people and machines in execution of their tasks. This is achieved by systems working in background, so-called Calm-systems and context-aware applications. In our case, context-aware means that the systems can take into consideration context information like the position and status of an object. These systems accomplish their tasks based on information coming from physical and virtual world. Information of the physical world is e.g. position or condition of a tool, in contrast to information of the virtual world like electronic documents, drawings and simulation models. These systems are working on different levels of the factory, like context-aware information systems in the shop floor (workers cockpit) or advanced manufacturing execution systems that can act context-aware for the shop floor manager. Calm systems are referring in this context the hardware of a Smart Factory. The main difference between calm and other types of systems is the ability to communicate and interact with its environment.

### 2.2 Challenges

The Smart Factory concept enables the real-time collection, distribution and access of manufacturing relevant information anytime and anywhere. The Smart Factory represents a realtime, context-sensitive manufacturing environment that can handle turbulences in production using decentralized information and communication structures for an optimum management of production processes. Premises for further assistance than today are the horizontal and vertical integration of information systems, the assignment of material and flow of information within an enterprise. For acting context-aware, the applications in the Smart factory have to answer the following three questions, from those deriving more challenges:

1 How is an object identified? => Identification phase

2 Where is an object located into the factory? => Positioning phase

3 What is the situation or status of an object? => Status knowledge

2『感觉这的信息就是论文的核心，智慧工厂要回答的三个问题，做一张主题卡片。（2021-01-28）』

These and further challenges are shortly presented:

Identification: The Identification of objects, as one of the basic challenges in a factory, assigns information of the virtual world like process steps to real world objects. Therefore suitable identification methods, tags, sensors, sensor readers and communication facilities have to be found and chosen, specific to their task in a rough industrial environment.

Localization: For improving the processes and reducing idle times within the Smart Factory the localization is required to have an actual knowledge about the position of the objects like tools or materials. Depending on the purpose, the accuracy of a positioning system has to be a range within 0.15-1m. Furthermore a positioning system used in a manufacturing environment has to work on a large scale and has to be robust against environmental influences, electromagnetic fields, noise of dust, etc. [3].

Status knowledge: The assistance systems in a Smart Factory have to know the status or situation of the objects in order to provide users the context-aware information.

Update of smart management systems: Current object information like the status or location has to be communicated to the systems of the Smart Factory. As an example the highly dynamical data like the position of an object should be updated every 10 to 30 seconds [3].

Support for different queries: Assistance systems in the Smart Factory have to support different kinds of queries [3]. We can differentiate into object-based, location-based/spatial, temporal and combinations of the previous types of queries.

Integration of heterogeneous information: The integration challenge of different systems in an enterprise is caused by different information models, interfaces and data formats. In order to provide other systems easy accessible information, different systems have to be integrated into a common synchronizing platform.

Real-time characterized reaction: For supporting people and machines information has to be provided within seconds. This challenge addresses mainly communications technologies and database management.

### 2.3 Enabling Technologies

![](./res/2021006.png)

Figure 1: Smart Factory

The implementation of the Smart Factory is enabled by several technologies, in the following shortly presented (Figure 1). An application of the Smart Factory consists of a Calm-system (referring more to hardware components) and a context-aware application (referring more to software components).

Embedded Systems: To provide small computing power for decentralized intelligent functions, microcontrollers have been developed in the last few years. They are optimized to low energy consumption for working in mobile devices. Today a wide range of「easy-to-use」microcontrollers are on the market with different computing power ranges, like the AVR or Pic microcontroller or the Xscale processors families.

(Wireless) Communication Technology: Calm systems have the ability to communicate with its environment. Today low mobile resources like a milling machine have got built in LAN or Fieldbus technology to communicate with higher-level enterprise systems like a MES. Recent developments tend to use wireless data transfers for low mobile resources as well as for mobile objects like tools or materials. These technologies are enabling ad-hoc networking of two or more devices and are usually classified after their cover range. Telecommunications technologies for second (e.g. EDGE/GPRS) and third generation (e.g. UMTS) cell phones and WiMAX/WiBro cover long distances up to several kilometers, whereas for short distances e.g. in a factory building, Wireless-LAN, Bluetooth/WIBREE and ZIGBEE are used.

Automatic Identification (Auto-ID) Technologies: Automatic identification technologies are other essential technologies for a Smart Factory for assigning virtual data to real objects, especially Barcode and RFID (Radio Frequency Identification) technologies are important for manufacturing purposes. The advantages of RFID compared to Barcodetechnology are its non-contact, non-line-of-sight nature, the possibilities to store more than just a number and integrating additional sensors e.g. for temperature and humidity. But barcodes are still wide spread in industry, due to its low costs.

Positioning Technologies: Location information is probably one of the most important factors in ubiquitous computing. Methods like triangulation, scene analysis and proximity are mainly used to determine a position of an object [5].

Federation Platform (Nexus Platform): The federation technology provides an easy access for applications to heterogeneous data. The Nexus Platform is developed within the Center of Excellence Nexus (SFB 627) provides context-aware’s applications a homogenous interface for querying context information of different heterogeneous databases. The context information is stored the in so-called context servers. Currently two types of context server are existing, one for spatial data and one for highly dynamic location data of objects.

Situation Recognition: In order to provide people in their tasks the right information at the right moment the assistance systems have to know the situation of their users. Therefore situation recognition becomes an important enabling technology for context-aware applications.

Sensor Fusion: Today's applications often use hard coded systems specifically designed for their task, giving no information to other systems. Sensor fusion technology is used in the Smart Factory for combining different raw sensor values for an aggregation or better measurements. Furthermore having all kinds of sensor data easy accessible via the Nexus Platform in the Smart Factory environment new kinds of measurements can be created for an easy implementation of new context-aware applications.

## 03. Positioning of the Smart Factory into the Functional Architecure of a Manufacturing Enterprise

The manufacturing enterprise has to fulfill along its processes several main functions, graphically represented in Figure 2. As shown, the main phases of factory life cycle are investment planning, site and building planning, the planning of infrastructure and processes, layout planning, ramp-up and project management, manufacturing execution, maintenance, education and training. The architecture introduces the complexity of managing the data's diversity and heterogeneity, which comes from different applications and information systems. Due to the real-time informing and controlling character, the Smart Factory focuses mainly the manufacturing execution, maintenance, education and training functions of a manufacturing enterprise, as shown in Figure 2.

![](./res/2021007.png)

Figure 2: Functional architecture of a manufacturing enterprise (PDM: Product Data Management).

But also other functions in a manufacturing enterprise gain advantages from the up-to-date data of the Smart Factory. Especially functions from factory life cycle like the planning of processes and equipment can benefit from the information coming from the Smart Factory.

Opposite to other existing applications, the information of the Smart Factory is context-aware. The Smart Factory has the potential to canalize information overflow and provide people decision support in production activities. With context-aware applications the manufacturing processes can be optimized and times e.g. for tool searching reduced.

As an example, a situation of a maintenance task is shortly presented in the following. The scenario represents a breakdown of a milling machine and shows the advantages of the Smart Factory usage. As a first step the machine is sending an error message after breakdown. With this information the maintenance worker and the shop floor manager are notified. From here the error information will be analyzed and assigned to a suitable workflow. If it is already documented as an error the worker gets the repairing steps and required tools. Furthermore the locations of the tools are available and displayed in the application. Then the worker can order the tools or grab them itself on the way to the machine.

![](./res/2021008.png)

Figure 3: Architecture of the Smart Factory.

Arrived at the machine he can immediately start the repairing So the times of tooling search are minimized. The workflow has to be updated with the time, actions and used tools in order that the repairing knowledge is saved for further usage Furthermore with the time information the MES can reschedule the jobs and minimize the effects of the breakdown.

Figure 3 gives an overview of the envisioned Smart Factory The modules like a MES or a Smart Machine are connected via the Nexus Platform with the Augmented World Model that provides the exchange of sensor, process, job, geometric and further information in the factory. 

## 04. Related Work

In the research field of Smart Factories several other related work, relevant for the scientific community, have to be mentioned. These are in the following shortly presented

Smart Factorvkl: The Smart Factorykl is a project located in Kaiserslautern Germany. Current projects of Smart Factory KL are focused on the development of applications with Indoor Positioning Systems, universal Human Machine Interfaces, web-based information services and the integration of heterogeneous information systems [7].

/NT-MANUS: The Intelligent Networked Manufacturing System (INT MANUS) project is financed by the European Commission under the 6 framework. Goal of INT-MANUS is the development of a new technology, the so called Smart Connected-control Platform (SCC platform) for manufacturing enterprises 8]

## 05. Conclusions and Future Work

The downscaling of computer and sensor technologies supports the integration of knowledge at all scales of a holistic production system, aiming at increasing the transformability of the factory as a whole. The presented Smart Factory approach represents a real-time, context sensitive manufacturing environment that can handle turbulences in production using decentralized information and communication structures for an optimum management of Production processes. Based on the Nexus Platform it integrates heterogeneous information systems in manufacturing enterprise both horizontal (e. G. Between systems in the shop floor) and vertical (e. G. Between shop floor and management systems like ERP or MES) in order to reduce information deficits. In the framework of the research area Smart Factory at the Universitat Stuttgart, IFF, a Smart Factory environment has been developed and will be enhanced, aiming at implementing the vision of the next-generation real-time and context-aware production systems.

2『这里的总结算是本论文精华了，做一张信息数据卡片。（2021-01-28）』——已完成

## 06. REFERENCES

[1] Westkamper, E. Hummel, V. Ronnecke, T, 2005, The Stuttgart Enterprise Model Integrated Engineering of Strategic Operational Functions. N: EMS Proceedings, March 14-16, Cocoa Beach, Florida USA 379-384

[2] Weiser M., 1991, The Computer for the Twenty-first Century, In: Scientific American, 09/91, p. 94-110

[3] Westkamper, E. Jendoubi, L. Eissele, M. Ertl, T. 2006, Smart Factory -Bridging the gap between digita planning and reality. In: Manufacturing Systems 35 No.4, p.307-314.

[4] Sonderforschungsbereich 627 Nexus Umgebungsmodelle fur mobile kontextbezogene Anwendungen, Available at http /www.nexus.uni stuttgart. de/24.012008

[5] Hazas, M, Ward, A, 2002, A Novel Broadband Ultrasonic Location System, In: Ubicomp 2002 Proceedings, September 29 - October 1, Goteborg Sweden, Springer Verlag, p. 264-280

[6] Bauer, M. Jendoubi, L; Rothermel, K; Westkamper, E, Grundlagen ubiquitarer Systeme und deren Anwendung in dersmart Factory. In: Industrie Management 19 (2003), Nr. 6, p 17-20