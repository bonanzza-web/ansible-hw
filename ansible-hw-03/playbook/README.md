# Домашнее задание к занятию 3 «Использование Ansible»

## Подготовка к выполнению

1. Подготовьте в Yandex Cloud три хоста: для `clickhouse`, для `vector` и для `lighthouse`.
2. Репозиторий LightHouse находится [по ссылке](https://github.com/VKCOM/lighthouse).

## Основная часть

1. Допишите playbook: нужно сделать ещё один play, который устанавливает и настраивает LightHouse.
2. При создании tasks рекомендую использовать модули: `get_url`, `template`, `yum`, `apt`.
3. Tasks должны: скачать статику LightHouse, установить Nginx или любой другой веб-сервер, настроить его конфиг для открытия LightHouse, запустить веб-сервер.
4. Подготовьте свой inventory-файл `prod.yml`.
5. Запустите `ansible-lint site.yml` и исправьте ошибки, если они есть.
6. Попробуйте запустить playbook на этом окружении с флагом `--check`.
7. Запустите playbook на `prod.yml` окружении с флагом `--diff`. Убедитесь, что изменения на системе произведены.
8. Повторно запустите playbook с флагом `--diff` и убедитесь, что playbook идемпотентен.
9. Подготовьте README.md-файл по своему playbook. В нём должно быть описано: что делает playbook, какие у него есть параметры и теги.
10. Готовый playbook выложите в свой репозиторий, поставьте тег `08-ansible-03-yandex` на фиксирующий коммит, в ответ предоставьте ссылку на него.

Ответ:  

Запуск с --check:  

bonanzza@debian2:~/ansible-hw/ansible-hw-03/playbook$ ansible-playbook -u centos site.yml --check  

PLAY [Install Nginx] ************************************************************************************************************************************************  

TASK [Gathering Facts] **********************************************************************************************************************************************  
ok: [lighthouse-01]  

TASK [NGINX | Install epel-release] *********************************************************************************************************************************  
ok: [lighthouse-01]  

TASK [NGINX | Install NGINX] ****************************************************************************************************************************************  
ok: [lighthouse-01]  

TASK [NGINX | Create file for lighthouse config] ********************************************************************************************************************  
ok: [lighthouse-01]  

TASK [NGINX | Create general config] ********************************************************************************************************************************  
ok: [lighthouse-01]  

PLAY [Install LightHouse] *******************************************************************************************************************************************  

TASK [Gathering Facts] **********************************************************************************************************************************************  
ok: [lighthouse-01]  

TASK [Lighthouse | Install dependencies] ****************************************************************************************************************************  
ok: [lighthouse-01]  

TASK [Lighthouse | Copy from git] ***********************************************************************************************************************************  
ok: [lighthouse-01]  
 
TASK [Lighthouse | Create lighthouse config] ************************************************************************************************************************  
ok: [lighthouse-01]  

PLAY [Install Clickhouse] *******************************************************************************************************************************************  
   
TASK [Gathering Facts] **********************************************************************************************************************************************  
ok: [clickhouse-01]  

TASK [Get clickhouse distrib] ***************************************************************************************************************************************  
ok: [clickhouse-01] => (item=clickhouse-client)  
ok: [clickhouse-01] => (item=clickhouse-server)  
failed: [clickhouse-01] (item=clickhouse-common-static) => {"ansible_loop_var": "item", "changed": false, "dest": "./clickhouse-common-static-22.3.3.44.rpm", "elapsed": 0, "gid": 1000, "group": "centos", "item": "clickhouse-common-static", "mode": "0664", "msg": "Request failed", "owner": "centos", "response": "HTTP Error 404: Not Found", "secontext": "unconfined_u:object_r:user_home_t:s0", "size": 246310036, "state": "file", "status_code": 404, "uid": 1000, "url": "https://packages.clickhouse.com/rpm/stable/clickhouse-common-static-22.3.3.44.noarch.rpm"}  

TASK [Get clickhouse distrib] ***************************************************************************************************************************************  
ok: [clickhouse-01]  

TASK [Install clickhouse packages] **********************************************************************************************************************************     
ok: [clickhouse-01]  

TASK [Create database] **********************************************************************************************************************************************  
skipping: [clickhouse-01]  

PLAY [Install and config Vector] ************************************************************************************************************************************  

TASK [Gathering Facts] **********************************************************************************************************************************************  
ok: [vector-01]  

TASK [Add clickhouse addresses to /etc/hosts] ***********************************************************************************************************************  
ok: [vector-01] => (item=clickhouse-01)  

TASK [Get vector distrib] *******************************************************************************************************************************************  
fatal: [vector-01]: FAILED! => {"changed": false, "dest": "./vector-0.29.1-1.x86_64.rpm", "elapsed": 0, "msg": "Request failed", "response": "HTTP Error 404: Not Found", "status_code": 404, "url": "https://packages.timber.io/vector/latest/vector-0.29.1-1.x86_64.rpm"}  

PLAY RECAP **********************************************************************************************************************************************************  
clickhouse-01              : ok=3    changed=0    unreachable=0    failed=0    skipped=1    rescued=1    ignored=0  
lighthouse-01              : ok=9    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0  
vector-01                  : ok=2    changed=0    unreachable=0    failed=1    skipped=0    rescued=0    ignored=0  


Запуск с --diff:  

bonanzza@debian2:~/ansible-hw/ansible-hw-03/playbook$ ansible-playbook -u centos site.yml --diff  

PLAY [Install Nginx] ************************************************************************************************************************************************  

TASK [Gathering Facts] **********************************************************************************************************************************************  
ok: [lighthouse-01]  

TASK [NGINX | Install epel-release] *********************************************************************************************************************************    
ok: [lighthouse-01]  

TASK [NGINX | Install NGINX] ****************************************************************************************************************************************  
ok: [lighthouse-01]  

TASK [NGINX | Create file for lighthouse config] ********************************************************************************************************************  
--- before  
+++ after  
@@ -1,6 +1,6 @@  
 {  
-    "atime": 1686300306.4374647,  
-    "mtime": 1686300285.60233,  
+    "atime": 1686300340.15832,  
+    "mtime": 1686300340.15832,  
     "path": "/etc/nginx/conf.d/lighthouse.conf",  
-    "state": "file"  
+    "state": "touch"  
 }  

changed: [lighthouse-01]  

TASK [NGINX | Create general config] ********************************************************************************************************************************  
ok: [lighthouse-01]  

PLAY [Install LightHouse] *******************************************************************************************************************************************  

TASK [Gathering Facts] **********************************************************************************************************************************************  
ok: [lighthouse-01]  

TASK [Lighthouse | Install dependencies] ****************************************************************************************************************************  
ok: [lighthouse-01]  

TASK [Lighthouse | Copy from git] ***********************************************************************************************************************************  
ok: [lighthouse-01]  

TASK [Lighthouse | Create lighthouse config] ************************************************************************************************************************  
ok: [lighthouse-01]  

PLAY [Install Clickhouse] *******************************************************************************************************************************************  

TASK [Gathering Facts] **********************************************************************************************************************************************  
ok: [clickhouse-01]  

TASK [Get clickhouse distrib] ***************************************************************************************************************************************  
ok: [clickhouse-01] => (item=clickhouse-client)  
ok: [clickhouse-01] => (item=clickhouse-server)  
failed: [clickhouse-01] (item=clickhouse-common-static) => {"ansible_loop_var": "item", "changed": false, "dest": "./clickhouse-common-static-22.3.3.44.rpm", "elapsed": 0, "gid": 1000, "group": "centos", "item": "clickhouse-common-static", "mode": "0664", "msg": "Request failed", "owner": "centos", "response": "HTTP Error 404: Not Found", "secontext": "unconfined_u:object_r:user_home_t:s0", "size": 246310036, "state": "file", "status_code": 404, "uid": 1000, "url": "https://packages.clickhouse.com/rpm/stable/clickhouse-common-static-22.3.3.44.noarch.rpm"}  

TASK [Get clickhouse distrib] ***************************************************************************************************************************************  
ok: [clickhouse-01]  

TASK [Install clickhouse packages] **********************************************************************************************************************************  
ok: [clickhouse-01]  

TASK [Create database] **********************************************************************************************************************************************  
ok: [clickhouse-01]  

PLAY [Install and config Vector] ************************************************************************************************************************************  

TASK [Gathering Facts] **********************************************************************************************************************************************  
ok: [vector-01]  

TASK [Add clickhouse addresses to /etc/hosts] ***********************************************************************************************************************  
ok: [vector-01] => (item=clickhouse-01)  

TASK [Get vector distrib] *******************************************************************************************************************************************  
fatal: [vector-01]: FAILED! => {"changed": false, "dest": "./vector-0.29.1-1.x86_64.rpm", "elapsed": 0, "msg": "Request failed", "response": "HTTP Error 404: Not Found", "status_code": 404, "url": "https://packages.timber.io/vector/latest/vector-0.29.1-1.x86_64.rpm"}  

PLAY RECAP **********************************************************************************************************************************************************  
clickhouse-01              : ok=4    changed=0    unreachable=0    failed=0    skipped=0    rescued=1    ignored=0  
lighthouse-01              : ok=9    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0  
vector-01                  : ok=2    changed=0    unreachable=0    failed=1    skipped=0    rescued=0    ignored=0  

- name: Установка и настройка LightHouse  
  hosts: lighthouse   
  become: true  
  tasks:  
    - name: Скачиваем LightHouse  
      get_url:  
        url: https://example.com/lighthouse-static.tar.gz  
        dest: /tmp/lighthouse-static.tar.gz  
    - name: Распаковываем LightHouse  
      unarchive:  
        src: /tmp/lighthouse-static.tar.gz  
        dest: /var/www/html/lighthouse  
        remote_src: true  
    - name: Устанавка Nginx  
      yum:  
        name: nginx  
        state: present  
    - name: Настройка конфига Nginx  
      template:  
        src: nginx.conf.j2  
        dest: /etc/nginx/nginx.conf  
        owner: root  
        group: root  
        mode: '0644'  
      notify:  
        - Restart Nginx  
    - name: Запуск веб-сервер Nginx  
      service:  
        name: nginx  
        state: started  
        enabled: true  
  handlers:  
    - name: Restart Nginx  
      service:  
        name: nginx  
        state: restarted  


---


### Отеты на дополнительные вопросы:
1. Версия ansible 2.14.3
2. Плейбук запускает установку clickhouse на один хост, vector на другой lighthouse на третий. Вместе с lighthouse ставится nginx. Плейбук запускается стандартной командой
3. Переменные clickhouse:
   clickhouse_version: "22.3.3.44"
   clickhouse_packages:
     - clickhouse-client
     - clickhouse-server
     - clickhouse-common-static
   Переменные vector:
   vector_version: "0.29.1-1"
   vector_config:
     sources:
       dummy_logs:
         type: demo_logs
         format: syslog
         interval: 1
     transforms:
       parse_logs:
         inputs:
         - dummy_logs
         source: |-
           . = parse_syslog!(string!(.message))
           .timestamp = to_string(.timestamp)
           .timestamp = slice!(.timestamp, start:0, end: -1)
         type: remap
     sinks:
       to_clickhouse:
         type: clickhouse
         inputs:
           - parse_logs
         database: logs2
         endpoint: 'http://clickhouse-01:8123'
         table: log
         compression: gzip
     api:
       enabled: true
       address: '0.0.0.0:8686'
     Переменные lighthouse:
     lighthouse_vcs: "https://github.com/VKCOM/lighthouse"
     lighthouse_location_dir: "/var/www/lighthouse"
4. Сценарии запуска (через теги/роли, если такие есть). Роли будут в следующем задании! Запуск ansible-playbook


### Как оформить решение задания

Выполненное домашнее задание пришлите в виде ссылки на .md-файл в вашем репозитории.

---
