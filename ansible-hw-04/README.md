# Домашнее задание к занятию 2 «Работа с Playbook»

## Подготовка к выполнению

1. * Необязательно. Изучите, что такое [ClickHouse](https://www.youtube.com/watch?v=fjTNS2zkeBs) и [Vector](https://www.youtube.com/watch?v=CgEhyffisLY).
2. Создайте свой публичный репозиторий на GitHub с произвольным именем или используйте старый.
3. Скачайте [Playbook](./playbook/) из репозитория с домашним заданием и перенесите его в свой репозиторий.
4. Подготовьте хосты в соответствии с группами из предподготовленного playbook.

## Основная часть

1. Подготовьте свой inventory-файл `prod.yml`.
2. Допишите playbook: нужно сделать ещё один play, который устанавливает и настраивает [vector](https://vector.dev).
3. При создании tasks рекомендую использовать модули: `get_url`, `template`, `unarchive`, `file`.
4. Tasks должны: скачать дистрибутив нужной версии, выполнить распаковку в выбранную директорию, установить vector.
5. Запустите `ansible-lint site.yml` и исправьте ошибки, если они есть.
6. Попробуйте запустить playbook на этом окружении с флагом `--check`.
7. Запустите playbook на `prod.yml` окружении с флагом `--diff`. Убедитесь, что изменения на системе произведены.
8. Повторно запустите playbook с флагом `--diff` и убедитесь, что playbook идемпотентен.
9. Подготовьте README.md-файл по своему playbook. В нём должно быть описано: что делает playbook, какие у него есть параметры и теги.
10. Готовый playbook выложите в свой репозиторий, поставьте тег `08-ansible-02-playbook` на фиксирующий коммит, в ответ предоставьте ссылку на него.

Ответ:  

Install Clickhouse:
Устанавливает ClickHouse на хосты, определенные в группе clickhouse.  
Перезапускает службу clickhouse-server, используя модуль ansible.builtin.service.  

Get clickhouse distrib:  
Загружает ClickHouse дистрибутивы из репозитория с помощью модуля ansible.builtin.get_url.  
Использует цикл with_items для перебора элементов из списка clickhouse_packages и загружает соответствующие пакеты.  

Install clickhouse packages:  
Устанавливает ClickHouse пакеты на целевых хостах с помощью модуля ansible.builtin.yum.  
Список пакетов для установки формируется с использованием директивы name и шаблонов с переменными.  

Flush handlers:  
Вызывает обработчики (handler) для выполнения действий, связанных с перезапуском службы ClickHouse.  

Create database:  
Создает базу данных ClickHouse с помощью команды clickhouse-client.  
Результат выполнения команды регистрируется с помощью директивы register, а проверки на ошибки и изменения задаются через директивы failed_when и changed_when.  

Install and config Vector:  
Устанавливает и настраивает Vector на хосты, определенные в группе vector.  
Перезапускает службу vector, используя модуль ansible.builtin.service.  

Add clickhouse addresses to /etc/hosts:  
Добавляет записи в файл /etc/hosts для хостов ClickHouse.  
Использует модуль ansible.builtin.lineinfile, чтобы проверить наличие записей и добавить их при необходимости.  

Get vector distrib:  
Загружает Vector дистрибутив из указанного источника с помощью модуля ansible.builtin.get_url.  

Install vector package:  
Устанавливает Vector пакет на целевых хостах с помощью модуля ansible.builtin.yum.  

Vector config name:  
Использует модуль ansible.builtin.lineinfile, чтобы изменить значение переменной VECTOR_CONFIG в файле /etc/default/vector на путь к конфигурационному файлу Vector.  

Create vector config:  
Создает конфигурационный файл Vector /etc/vector/config.yaml с помощью модуля ansible.builtin.copy.  
Использует фильтр to_nice_yaml для форматирования данных в формат YAML.  

---

### Как оформить решение задания

Выполненное домашнее задание пришлите в виде ссылки на .md-файл в вашем репозитории.

---
