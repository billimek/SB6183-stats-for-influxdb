# SB6183 Modem Stats emitted to Influxdb running as a Docker container

![Screenshot]()

This tool is a parser of the Arris SB6183 cable modem to emit signal & power metrics to InfluxDB

## Grafana dashboard example
See this [example json](sb6183-modem-stats.json) for a grafana dashboard as shown in the screenshot above

## Configuration within config.ini

#### GENERAL
|Key            |Description                                                                                                         |
|:--------------|:-------------------------------------------------------------------------------------------------------------------|
|Delay          |Delay between runs                                                                                                  |
|Output         |Write console output while tool is running                                                                          |
#### INFLUXDB
|Key            |Description                                                                                                         |
|:--------------|:-------------------------------------------------------------------------------------------------------------------|
|Address        |Delay between updating metrics                                                                                      |
|Port           |InfluxDB port to connect to.  8086 in most cases                                                                    |
|Database       |Database to write collected stats to                                                                                |
|Username       |User that has access to the database                                                                                |
|Password       |Password for above user                                                                                             |
#### MODEM
|Key            |Description                                                                                                         |
|:--------------|:-------------------------------------------------------------------------------------------------------------------|
|URL         |URL of the cable modem info page.  Leave blank for http://192.168.100.1/RgConnect.asp                                                            |

## Usage

Before the first use run pip3 install -r requirements.txt

Enter your desired information in config.ini and run SB6183.py

Optionally, you can specify the --config argument to load the config file from a different location.  

***Requirements***

Python 3+

You will need the influxdb library installed to use this - [Found Here](https://github.com/influxdata/influxdb-python)

## Docker Setup

1. Install [Docker](https://www.docker.com/)

2. Make a directory to hold the config.ini file. Navigate to that directory and download the sample config.ini in this repo.

```bash
mkdir SB6183-stats-for-influxdb
curl -O https://raw.githubusercontent.com/billimek/SB6183-stats-for-influxdb/blob/master/config.ini SB6183-stats-for-influxdb/config.ini
cd SB6183-stats-for-influxdb
```

3. Modify the config file with your influxdb settings.

```bash
vim config.ini
```

Modify the 'Address =' line include the ip or hostname of your influxdb instance.
Example:

```bash
Address = 10.13.14.200
```

. Run the container, pointing to the directory with the config file. This should now pull the image from Docker hub. You can do this by either running docker run or by using docker-compose.

```bash
docker run -d \
--name="sb6183" \
-v $PWD/config.ini:/src/config.ini \
--restart="always" \
billimek/sb6183-for-influxdb
```