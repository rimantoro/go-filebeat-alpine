# Go - Filebeat - Alpine

Go with Elastic filebeat service installed on Alpine linux.

## Environment Variables

FILEBEAT_VERSION = version of filebeat, default ```6.4.1```.
LOGSTHOST = logstash host (and port) as output, default ```logstash:5000```


## Filebeat.yml

```filebeat.yml``` located in root ( ```/``` ) direcotry. If you want to use your own, please put your file in root directory.

## How to share log volume

You need create a docker volume containing logs, and mount those volume into a container which use this image and set the desired ```input paths``` with mounted directory.

I.e : If you have a volume named ```logs-volume``` and mounted inside container with ```/var/logs/applogs```, then you need to set input path to look like this.

```yaml
filebeat.inputs:
- type: log
  # put your paths here
  paths:
    - /var/logs/applogs/*.log
  # if the target file is a symlink
  symlinks: true
  fields:
    docType: app-logs
  document_type: app-logs
  ignore_older: 72h
  json.message_key: msg
  json.keys_under_root: true
  json.add_error_key: true
```
