# Digital tracking and profiling for consumer intelligence systems. Design and implementation of a behavioral – centric Data Warehouse

## Research context

**Companies have
developed systems that allow them to have an extremely detailed understanding of
consumers**: they know when their customers are sad, when they are happy, how
much they sleep, what they eat, who they spend time with, what life goals they
have, and the list can go on endlessly. In some cases, accurate analysis can even
determine what consumers (generally) think, even if it seems like science fiction. All
of these efforts serve a single purpose: to find out what consumers truly desire, in
order to make profit. Certainly, these aspects have a major beneficial impact on the
economy, but there are also social consequences: **the loss of privacy and the manipulation of consumer masses**. Of course, such data infrastructures and architectures
that enable this kind of things to happen are not publically available because competition comes into play. However, by conducting thorough research and by closely
observing my everyday experiences in the digital world, **I have managed to replicate such an architectural setup. This work presents the implementation of such a
system**

## Motivation

The motivation behind this work arises from **the understanding that the use of
data-driven systems to make decisions about people can have a profound impact
on their choices, opportunities, and future outcomes**. Personalization can be easily
used to exploit personal weaknesses, manipulate individuals into specific behaviors,
and exert significant influence on a larger scale.
Although this work does not provide direct solutions, **it assesses, explain and
provide a framework for understanding the current state of data infrastructures that
deal with personal data of consumers.**

## Research Question

**What type of data architecture would support a comprehensive understanding of
consumers, enabling detailed insights into their behaviors and preferences?**

## System Architecture

I have implemented a **Data Warehouse infrastructure that runs on Docker containers** and has the following main characteristics:
* It consists of two main layer: **a storage layer and an access layer**;
* The storage layer was built using **PostgreSQL**. Relational databases are particularly optimal for applications like consumer behavior analysis. When data
can be efficiently organized in rows and columns, similar to a spreadsheet,
SQL-based databases like PostgreSQL or BigQuery is the optimal choice. This
is because relational databases excel at analyzing structured data in tabular
formats.
* The second main part of DW is the access layer which consists of running
**Apache Spark applications for processing and analytics** but also for the transformation part of the data from the staging area.
* The storage layer of the data warehouse is further divided into 3 distinct
elements:
     * **Staging and integration area**: which serves as a Data Lake-like repository
where ELT can be performed using Spark, but also integrating data into
the next state;
     * **Data warehouse**: The DB consisting of clean data and also with all
the well - defined relationships between tables. Here the data can be
queried using PostgreSQL syntax but also aggregated using PySpark or
SparkSQL;
     * **Data marts layer** : where the DW is further divided into different denormalized dimensions to facilitate the query and aggregation of data;
* The access layer is used primary for conducting tasks as **data mining and
analysis** but also for **developing or deploying machine learning models**.

## Data sources

* **dating app.csv** – a csv file with records about the relationship status, body
type, orientation, religion, use of drugs or alcohol,etc.;
* **reviews.csv** – a csv file containing pieces of text of consumer’s reviews on
various products along with the timestamp;
* **stress level.csv** – a csv file containing indices of consumer’s stress level based
on an IoT device;
* **audio files** – a file with the path to audio recordings of consumer’s environment with the help of the enabled “microphone on” option of an app;
* **smart watch.csv** – a csv file with data instances recorded by a fitness application of a smartwatch. It has attributes like: total steps/distance, calories,
minutes asleep;
* **heart rate.csv** – a file containing the heart rates of consumers collected by
a fitness app;
* **symptoms.csv** – a CSV file containing the symptoms searched by the consumer on his browser
* **mental health.csv** – a CSV containing pieces of text which represents comments of consumers on social media. A corpus of text used in along with a
pre trained model which detects stress/depression/anxiety based on human
language.
* **cookies.csv** – a CSV file that keeps data like the system used by the consumer (smartphone or laptop), the type of the OS, the name of the device
manufacturer, the host, the number of requests and the part of day when the
request was made (morning, evening);
* **logs.csv** – with attributes like timestamp, URL and status (200, 302, 404,
etc);
* **web history.csv** – a CSV file consisting of the browsing history of each consumer. It keeps data like URL, first visit, last visit, click count and frequency;
* **click ads.csv** – a file consisting of information if consumer clicked on an add
and what kind of add was (indexed with an ad id)
* **bank loan.csv** – a CSV file containing pieces of information about consumers
like if they have a bank loan, what was the purpose of it, the amount of the
loan and if the consumer owns or not a house or property;
* **credit card.csv** – a csv file consisting of transactions made by consumers
with their credit card, transaction time and date, amount, etc;
* **online retail.csv** – a csv file with various items purchased by consumers
using a retail app, the timestamp, number of items purchased, etc;
* **demographics.csv** – a csv file consisting of demographics attributes of each
consumer, like age, gender, work class, education, occupation, salary, marital
status, race and zip code
* **microphine recording** - a directory consisting of smartphone mic .wav files.

## Dimensional Modeling

Data Warehouses are separate systems specifically designed for analysis and reporting purposes. This requires a special dimensional modeling method 
called Online Analytical Processing (OLAP). You can find the ERD and the system design diagram in the PDFs from this repository.
