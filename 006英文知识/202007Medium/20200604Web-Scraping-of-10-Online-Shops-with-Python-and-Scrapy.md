# Web Scraping of 10 Online Shops in 30 Minutes with Python and Scrapy

Erdem Isbilen

Nov 20, 2019 · 15 min read

[Web Scraping of 10 Online Shops in 30 Minutes with Python and Scrapy](https://towardsdatascience.com/web-scraping-of-10-online-shops-in-30-minutes-with-python-and-scrapy-a7f66e42446d)

First: 1) You are a full-stack developer. 2) You would like to develop a fantastic WebApplication. 3) You are motivated and fully dedicated to your project.

Even if you tick the above boxes, you still need a domain related dataset before writing a single line of code. This is because modern applications process huge amounts of data simultaneously or in batches to provide value for their users.

In this post, I will explain my workflow of generating such a dataset. You will see how I handle automated web scraping of many websites without any manual intervention. I aim to generate a dataset for a Price Comparision WebApp. The product category I will be using as an example is hand-bags. For such an application, product and price information of hand-bags should be collected from different online-sellers daily. Although some sellers provide an API for you to access the required information, not all of them follow the same route. So, web scrapping is inevitable!

Throughout this example, I will generate web spiders for 10 different sellers using Python and Scrapy. Then, I will automate the process with Apache Airflow so that there is no need for manual interventions to carry out the whole process periodically.

## 01. Source Code and Live Demo Web App

You can find all the related source code in my GitHub repository. You can also visit the live web app which uses the data supplied by this web scrapping project.

3『

[eisbilen/FashionSearch: Angular Front End with Python&AirFlow Data Pipeline](https://github.com/eisbilen/FashionSearch)

[TrendVar - Moda Arama Motoru](https://fashionsearch-2cab5.web.app/)

已 forked 源码存入「2020017FashionSearch」。

』

## 02. My Web Scraping Workflow

Before starting any web scraping project, we have to define which websites will be covered in the project. I decided to cover 10 websites which are the most visited online shops in Turkey for the hand-bags category. You can see them all in my GitHub repository.

### Step1: Installing Scrapy and Setting Up Project Folders

You have to install the Scrapy into your computer and generate a Scrapy project before creating the Scrapy spiders. Please take a look at the below post for further information.

[Fuel Up the Deep Learning: Custom Dataset Creation with Web Scraping](https://towardsdatascience.com/fuel-up-the-deep-learning-custom-dataset-creation-with-web-scraping-ba0f44414cf7)

```
#install the scrapy
$ pip install scrapy

#install the image for downloading the product images
$ pip install image

#start web scraping project with scraps
$ scrapy startproject fashionWebScraping
$ cd fashionWebScraping
$ ls

#create project folders which are explained below
$ mkdir csvFiles
$ mkdir images_scraped
$ mkdir jsonFiles
$ mkdir utilityScripts
```

The folder structure of the project. I created a folder structure in my local computer to neatly place project files into the separate folders.

‘csvFiles’ folder contains a CSV file for each website scraped. Spiders will be reading from those CSV files to get the ‘starting URLs’ to initiate the scraping as I do not want to hard-code them in the spiders.

‘fashionWebScraping’ folder contains the Scrapy spiders and helper scripts like ‘settings.py’, ‘item.py’ and ‘pipelines.py’. We have to modify some of those Scrapy helper scripts to carry out the scraping process successfully.

Product images scraped will be saved in the ‘images_scraped’ folder.

During the process of web scraping, all product information like price, name, product link and image link will be stored in JSON files in ‘jsonFiles’ folder.

There will be utility scripts to carry out some tasks such as:  1) ‘deldub.py’ to detect and remove duplicate product information in the JSON files after scrapping ends. 2) ‘jsonPrep.py’ is another utility script to detect and delete null line items in the JSON files after scrapping ends. 3) ‘deleteFiles.py’ to delete all JSON files generated at previous scrapping session. 4) ‘jsonToes.py’ to populate ElasticSearch clusters in a remote location by reading from the JSON files. This is required to provide a real-time full-text search experience. 5) ‘sitemap\_gen.py’ is for generating a site map which covers all product links.

### Step2: Understanding Specific Website’s URL Structure and Populating CSV Files for Starting URLs

After the project folders are created, then the next step is to populate CSV files with the starting URLs for each website we would like to scrape.

Almost every e-commerce website offers pagination to navigate the users through the product lists. Every time you navigate to the next page, the page parameter in the URL increases. See an example URL below, where the ‘page’ parameter is used.

https://www.derimod.com.tr/kadin-canta-aksesuar/?page=1

I will use {} placeholder so that we can iterate the URL by incrementing the value of ‘page’. I will also use the ‘gender’ column in the CSV file to define the gender category of the specific URL.
So the final CSV file will look like this:

The same principles apply to the rest of the websites in the project. You can find the populated CSV files in my GitHub repository.

### Step3: Modifying ‘items.py’ and ‘settings.py’

To start scraping, we have to modify the ‘items.py’ to define the ‘item objects’ which are used to store the scraped data.

To define common output data format Scrapy provides the Item class. Item objects are simple containers used to collect the scraped data. They provide a dictionary-like API with a convenient syntax for declaring their available fields.

from scrapy.org

```
#items.py in fashionWebScraping folder
import scrapy
from scrapy.item import Item, Field
class FashionwebscrapingItem(scrapy.Item):
 
 #product related items, such as id,name,price
 gender=Field()
 productId=Field()
 productName=Field()
 priceOriginal=Field()
 priceSale=Field()
#items to store links
 imageLink = Field()
 productLink=Field()
#item for company name
 company = Field()
pass
class ImgData(Item):
#image pipline items to download product images
 image_urls=scrapy.Field()
 images=scrapy.Field()
 ```
 
Then we have to modify the ‘settings.py’. This is required to customize the image pipeline and behavior of spiders.
The Scrapy settings allow you to customize the behaviour of all Scrapy components, including the core, extensions, pipelines, and spiders themselves.
from scrapy.org

```
# settings.py in fashionWebScraping folder
# Scrapy settings for fashionWebScraping project
# For simplicity, this file contains only settings considered important or commonly used. You can find more settings consulting the documentation:
# https://doc.scrapy.org/en/latest/topics/settings.html
# https://doc.scrapy.org/en/latest/topics/downloader-middleware.html
# https://doc.scrapy.org/en/latest/topics/spider-middleware.html
BOT_NAME = 'fashionWebScraping'
SPIDER_MODULES = ['fashionWebScraping.spiders']
NEWSPIDER_MODULE = 'fashionWebScraping.spiders'
# Crawl responsibly by identifying yourself (and your website) on the user-agent
USER_AGENT = 'fashionWebScraping'
# Obey robots.txt rules
ROBOTSTXT_OBEY = True
# See https://doc.scrapy.org/en/latest/topics/settings.html
# download-delay
# See also autothrottle settings and docs
# This to avoid hitting servers too hard
DOWNLOAD_DELAY = 1
# Override the default request headers:
DEFAULT_REQUEST_HEADERS = {
'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
'Accept-Language': 'tr',
}
# Configure item pipelines
# See https://doc.scrapy.org/en/latest/topics/item-pipeline.html
ITEM_PIPELINES = {'scrapy.pipelines.images.ImagesPipeline': 1}
IMAGES_STORE = '/Users/erdemisbilen/Angular/fashionWebScraping/images_scraped'
```

‘item.py’ and ‘settings.py’ are valid for all spiders in our project.

### Step4: Building Spiders

Scrapy Spiders are classes which define how a certain site (or a group of sites) will be scraped, including how to perform the crawl (i.e. follow links) and how to extract structured data from their pages (i.e. scraping items). In other words, Spiders are the place where you define the custom behaviour for crawling and parsing pages for a particular site (or, in some cases, a group of sites).

from scrapy.org

```
fashionWebScraping $ scrapy genspider fashionBOYNER boyner.com
Created spider ‘fashionBOYNER’ using template ‘basic’ in module:
fashionWebScraping.spiders.fashionBOYNER
```

Above shell command creates an empty spider file. Let’s write the codes into our fashionBOYNER.py file:

```
# 'fashionBOYNER.py' in fashionWebScraping/Spiders folder
# import scrapy and scrapy items
import scrapy
from fashionWebScraping.items import FashionwebscrapingItem
from fashionWebScraping.items import ImgData
from scrapy.http import Request
# To read from a csv file
import csv
class FashionboynerSpider(scrapy.Spider):
 name = 'fashionBOYNER'
 allowed_domains = ['BOYNER.com']
 start_urls = ['http://BOYNER.com/']
# This function helps us to scrape the whole content of the website
 # by following the starting URLs in a csv file.
def start_requests(self):
# Read main category URLs from a csv file
with open ("/Users/erdemisbilen/Angular/fashionWebScraping/
  csvFiles/SpiderMainCategoryLinksBOYNER.csv", "rU") as f:
  
    reader=csv.DictReader(f)
for row in reader:
      url=row['url']
# Change the page value incrementally to navigate through
      the product list
      # You can play with the range value according to maximum  
      product quantity, 30 pages to scrape as default
      link_urls = [url.format(i) for i in range(1,30)]
for link_url in link_urls:
        print(link_url)
# Pass the each link containing products to 
        parse_ product_pages function with the gender metadata
request=Request(link_url, callback=self.parse_product_pages,
        meta={'gender': row['gender']})
yield request
# This function scrapes the page with the help of xpath provided
 def parse_product_pages(self,response):
 
  item=FashionwebscrapingItem()
  
  # Get the HTML block where all the products are listed
  # <div> HTML element with the "product-list-item" class name
content=response.xpath('//div[starts-with(@class,"product-list-
  item")]')
# loop through the each <div> element in the content
  for product_content in content:
image_urls = []
# get the product details and populate the items
   item['productId']=product_content.xpath('.//a/@data
   -id').extract_first()
item['productName']=product_content.xpath('.//img/@title').
   extract_first()
item['priceSale']=product_content.xpath('.//ins[@class=
   "price-payable"]/text()').extract_first()
item['priceOriginal']=product_content.xpath('.//del[@class=
   "price-psfx"]/text()').extract_first()
if item['priceOriginal']==None:
    item['priceOriginal']=item['priceSale']
item['imageLink']=product_content.xpath('.//img/
   @data-original').extract_first()
   
   item['productLink']="https://www.boyner.com.tr"+
   product_content.xpath('.//a/@href').extract_first()
image_urls.append(item['imageLink'])
item['company']="BOYNER"
   item['gender']=response.meta['gender']
if item['productId']==None:
    break
yield (item)
# download the image contained in image_urls
   yield ImgData(image_urls=image_urls)
def parse(self, response):
  pass
```

Our spider class contains 2 functions which are ‘start_requests’ and ‘parse_product_pages’.
In the ‘start_requests’ function, we read from the specific CSV file, which we already generated, to get the starting URL information. Then we iterate the placeholder {} to pass URLs of the product pages to ‘parse_product_pages’ function.
We can also pass the ‘gender’ meta-data to ‘parse_product_pages’ function in the ‘Request’ method with ‘meta={‘gender’: row[‘gender’]}’ parameter.
In the ‘parse_product_pages’ function, we perform the actual web scraping and populate the Scrapy items with the scraped data.
I use Xpath to locate the HTML sections which contain the product information on the web page.
The first Xpath expression below extracts the whole product list from the current page being scrapped. All required product information is contained in the ‘div’ elements of ‘content’.

```
#  // Selects nodes in the document from the current node that matches the selection no matter where they are
# '//div[starts-with(@class,"product-list-item")]' selects the all div elements which has class value start
content = response.xpath('//div[starts-with(@class,"product-list-item")]')
```

We need to loop through in the ‘content’ to reach individual products and store them in the Scrapy items. With the help of XPath expressions, we can easily locate the required HTML elements in the ‘content’.

```
# loop through the each <div> element in the content
  for product_content in content:
image_urls = []
# get the product details and populate the items
   
   # ('.//a/@data-id') extracts 'data-id' value of <a> element
   inside the product_content
   item['productId']=product_content.xpath('.//a/@data
   -id').extract_first()
# ('.//img/@title') extracts 'title' value of <img> element
   inside the product_content   
   item['productName']=product_content.xpath('.//img/@title').
   extract_first()
# ('.//ins[@class= "price-payable"]/text()') extracts text value
   of <ins> element which has 'price-payable' class attribute inside
   the product_content   
   item['priceSale']=product_content.xpath('.//ins[@class=
   "price-payable"]/text()').extract_first()
# ('.//del[@class="price-psfx"]/text()') extracts text value
   of <del> element which has 'price-psfx' class attribute inside
   the product_content
   item['priceOriginal']=product_content.xpath('.//del[@class=
   "price-psfx"]/text()').extract_first()
if item['priceOriginal']==None:
     item['priceOriginal']=item['priceSale']
# ('.//img/@data-original') extracts 'data-original' value of
   <img> element inside the product_content
   item['imageLink']=product_content.xpath('.//img/
   @data-original').extract_first()
# ('.//a/@href') extracts 'href' value of
   <a> element inside the product_content
   item['productLink']="https://www.boyner.com.tr"+
   product_content.xpath('.//a/@href').extract_first()
# assigns the product image link into the 'image_urls' which is
   defined in the image pipeline
   image_urls.append(item['imageLink'])
item['company']="BOYNER"
   item['gender']=response.meta['gender']
if item['productId']==None:
    break
yield (item)
 
   # download the image contained in image_urls
   yield ImgData(image_urls=image_urls)
```

Again, the same principles apply to other websites. You can see the codes of all 10 spiders in my GitHub repository.

### Step5: Running Spiders and Storing the Scraped Data in JSON File

During the scraping process, each product item is stored in a JSON file. Each website has a specific JSON file that is populated with data in each spider run.

    fashionWebScraping $ scrapy crawl -o rawdata_BOYNER.json -t jsonlines fashionBOYNER

Using jsonlines format is much more memory efficient compared to JSON format, especially if you are scraping a lot of web pages in one session.
Notice that the JSON file name starts with ‘rawdata’ which indicates that the next step is to check and validate the scrapped raw data before using them in our application.

### Step6: Cleaning and Validating the Scraped Data in JSON Files

After the scrapping process ends, you may have some line items you have to remove from the JSON files, before using them in your application.
You may have line items with null fields or duplicate values. Both cases require a correction process that I handle with ‘jsonPrep.py’ and ‘deldub.py’.
‘jsonPrep.py’ looks for the line items with null values and removes them when detected. You can find the code with explanations below:

```
# ‘jsonPrep.py’ in fashionWebScraping/utilityScripts folder
import json
import sys
from collections import OrderedDict
import csv
import os
# Reads from jsonFiles.csv file for the names and locations of all json files need to be validated 
with open("/Users/erdemisbilen/Angular/fashionWebScraping/csvFiles/ jsonFiles.csv", "rU") as f:
reader=csv.DictReader(f)
# Iterates the json files listed in jsonFiles.csv
 for row in reader:
 
  # Reads from jsonFiles.csv file for jsonFile_raw column
  jsonFile=row['jsonFile_raw']
# Opens the jsonFile
   with open(jsonFile) as json_file:
    data = []
    i = 0
seen = OrderedDict()
    
    # Iterates in the rows of json file
    for d in json_file:
     seen = json.loads(d)
# Do not include the line item if the product Id is null
     try:
      if seen["productId"] != None:
       for key, value in seen.items():
        print("ok")
        i = i + 1
        data.append(json.loads(d))
     
     except KeyError:
      print("nok")
    
    print (i)
    
    baseFileName=os.path.splitext(jsonFile)[0]
# Write the result as a json file by reading filename from the
    'file_name_prep' column
    with open('/Users/erdemisbilen/Angular/fashionWebScraping/
    jsonFiles/'+row['file_name_prep'], 'w') as out:
json.dump(data, out)
The result is saved, with a file name starts with ‘prepdata’, into the ‘jsonFiles’ project folder, after null line items are removed.
‘deldub.py’ looks for the duplicate line items and removes them when detected. You can find the code with explanations below:
# 'deldub.py' in fashionWebScraping/utilityScripts folder
import json
import sys
from collections import OrderedDict
import csv
import os
# Reads from jsonFiles.csv file for the names and locations of all json files need to be validated for dublicate lines
with open("/Users/erdemisbilen/Angular/fashionWebScraping/csvFiles/ jsonFiles.csv", newline=None) as f:
 
 reader=csv.DictReader(f)
# Iterates the json files listed in jsonFiles.csv
 for row in reader:
# Reads from jsonFiles.csv file for jsonFile_raw column
  jsonFile=row['jsonFile_prep']
# Opens the jsonFile
  with open(jsonFile) as json_file:
   data = json.load(json_file)
seen = OrderedDict()
   dubs = OrderedDict()
# Iterates in the rows of json file
   for d in data:
    oid = d["productId"]
# Don't include the item if the product Id has dublicate value
    if oid not in seen:
     seen[oid] = d
else:
     dubs[oid]=d
baseFileName=os.path.splitext(jsonFile)[0]
# Write the result as a json file by reading filename from the
     'file_name_final' column
with open('/Users/erdemisbilen/Angular/fashionWebScraping/
     jsonFiles/'+row['file_name_final'], 'w') as out:
      json.dump(list(seen.values()), out)
with open('/Users/erdemisbilen/Angular/fashionWebScraping/
     jsonFiles/'+'DELETED'+row['file_name_final'], 'w') as out:
      json.dump(list(dubs.values()), out)
```

The result is saved, with a file name starts with ‘finaldata’, into the ‘jsonFiles’ project folder, after duplicate line items are removed.

## Automating the Complete Scraping Workflow with the Apache Airflow

Once we defined the scraping process, we can then jump into the workflow automation. I will use Apache Airflow, which is a Python-based workflow automation tool developed by Airbnb.
I will provide the terminal commands for installing and configuring Apache Airflow, you can refer to my below post for further details.
My Deep Learning Journey: From Experimentation to Production
Build an Automated Machine Learning Pipeline with Apache Airflow
medium.com

```
$ python3 --version
Python 3.7.3$ virtualenv --version
15.2.0$ cd /path/to/my/airflow/workspace
$ virtualenv -p `which python3` venv
$ source venv/bin/activate
(venv) $ pip install apache-airflow
(venv) $ mkdir airflow_home
(venv) $ export AIRFLOW_HOME=`pwd`/airflow_home
(venv) $ airflow initdb
(venv) $ airflow webserver
```

### Creating a DAG file

In Airflow, a DAG – or a Directed Acyclic Graph – is a collection of all the tasks you want to run, organized in a way that reflects their relationships and dependencies.
For example, a simple DAG could consist of three tasks: A, B, and C. It could say that A has to run successfully before B can run, but C can run anytime. It could say that task A times out after 5 minutes, and B can be restarted up to 5 times in case it fails. It might also say that the workflow will run every night at 10 pm, but shouldn’t start until a certain date.
DAG’s, which are defined in a Python file, is for organizing the task flow. We will not be defining actual tasks inside the DAG file.
Let’s create a DAG folder and an empty python file to start defining our workflow with Python codes.

    (venv) $ mkdir dags

There are several operators provided by Airflow to describe the task inside a DAG file. I listed commonly used ones below.
BashOperator - executes a bash command
PythonOperator - calls an arbitrary Python function
EmailOperator - sends an email
SimpleHttpOperator - sends an HTTP request
Sensor - waits for a certain time, file, database row, S3 key, etc…
I am planning to use only the ‘BashOperator’ for now, as I will be completing all my tasks with python scripts.
As I will be using the ‘BashOperator’, it would be good to have a bash script containing all the commands for a specific task to simplify the dag file.
By following this tutorial, I generated the bash scripts for each task. You can find them all in my Github repository.
Then I can write my DAG file as shown below by using the bash commands I created. With the below configuration, my tasks will be scheduled and executed daily basis by Airflow. You can change the start date or the schedule intervals in the DAG file according to your needs. You may further use local executer or celery executer to run task instances in parallel. As I am using the sequential executer, which is the most primitive executer, all my task instances will work sequentially.

```
# 'fashionsearch_dag.py' in Airflow dag folder
import datetime as dt
from airflow import DAG
from airflow.operators.bash_operator import BashOperator
from datetime import datetime, timedelta
default_args = {
'owner': 'airflow',
'depends_on_past': False,
'start_date': datetime(2019, 11, 23),
'retries': 1,
'retry_delay': timedelta(minutes=5),
# 'queue': 'bash_queue',
# 'pool': 'backfill',
# 'priority_weight': 10,
# 'end_date': datetime(2016, 1, 1),
}
dag = DAG(dag_id='fashionsearch_dag', default_args=default_args, schedule_interval=timedelta(days=1))
# This task deletes all json files which are generated in previous scraping sessions
t1 = BashOperator(
task_id='delete_json_files',
bash_command='run_delete_files',
dag=dag)
# This task runs the spider for www.boyner.com
# And populates the related json file with data scraped
t2 = BashOperator(
task_id='boyner_spider',
bash_command='run_boyner_spider',
dag=dag)
# This task runs the spider for www.derimod.com
# And populates the related json file with data scraped
t3 = BashOperator(
task_id='derimod_spider',
bash_command='run_derimod_spider',
dag=dag)
# This task runs the spider for www.hepsiburada.com
# And populates the related json file with data scraped
t4 = BashOperator(
task_id='hepsiburada_spider',
bash_command='run_hepsiburada_spider',
dag=dag)
# This task runs the spider for www.hm.com
# And populates the related json file with data scraped
t5 = BashOperator(
task_id='hm_spider',
bash_command='run_hm_spider',
dag=dag)
# This task runs the spider for www.koton.com
# And populates the related json file with data scraped
t6 = BashOperator(
task_id='koton_spider',
bash_command='run_koton_spider',
dag=dag)
# This task runs the spider for www.lcwaikiki.com
# And populates the related json file with data scraped
t7 = BashOperator(
task_id='lcwaikiki_spider',
bash_command='run_lcwaikiki_spider',
dag=dag)
# This task runs the spider for www.matmazel.com
# And populates the related json file with data scraped
t8 = BashOperator(
task_id='matmazel_spider',
bash_command='run_matmazel_spider',
dag=dag)
# This task runs the spider for www.modanisa.com
# And populates the related json file with data scraped
t9 = BashOperator(
task_id='modanisa_spider',
bash_command='run_modanisa_spider',
dag=dag)
# This task runs the spider for www.morhipo.com
# And populates the related json file with data scraped
t10 = BashOperator(
task_id='morhipo_spider',
bash_command='run_morhipo_spider',
dag=dag)
# This task runs the spider for www.mudo.com
# And populates the related json file with data scraped
t11 = BashOperator(
task_id='mudo_spider',
bash_command='run_mudo_spider',
dag=dag)
# This task runs the spider for www.trendyol.com
# And populates the related json file with data scraped
t12 = BashOperator(
task_id='trendyol_spider',
bash_command='run_trendyol_spider',
dag=dag)
# This task runs the spider for www.yargici.com
# And populates the related json file with data scraped
t13 = BashOperator(
task_id='yargici_spider',
bash_command='run_yargici_spider',
dag=dag)
# This task checks and removes null line items in json files
t14 = BashOperator(
task_id='prep_jsons',
bash_command='run_prep_jsons',
dag=dag)
# This task checks and removes dublicate line items in json files
t15 = BashOperator(
task_id='delete_dublicate_lines',
bash_command='run_del_dub_lines',
dag=dag)
# This task populates the remote ES clusters with the data inside the JSON files
t16 = BashOperator(
task_id='json_to_elasticsearch',
bash_command='run_json_to_es',
dag=dag)
# With sequential executer, all tasks depends on previous task
# No paralell task execution is possible
# Use local executer at least for paralell task execution
t1 >> t2 >> t3 >> t4 >> t5 >> t6 >> t7 >> t8 >> t9 >> t10 >> t11 >> t12 >> t13 >> t14 >> t15 >> t16
```

To start a DAG workflow, we need to run the Airflow Scheduler. This will execute the scheduler with the configuration specified in ‘airflow.cfg’ file. Scheduler monitors each task in each DAG located in the ‘dags’ folder and triggers the execution of tasks if the dependencies have been met.

    (venv) $ airflow scheduler

Once we run the airflow scheduler, we can see the status of our tasks by visiting http://0.0.0.0:8080 on our browser. Airflow provides a user interface where we can see and track our scheduled dags.

AirFlow Dag Graph View

## Conclusion

I tried to show you my web scraping workflow from start to end. Hopefully, this will help you to grasp the basics of web scrapping and workflow automation.
