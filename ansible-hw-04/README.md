# Установка стека Clickhouse + Vector + Lighthouse    

Данный playbook автоматизирует установку и настройку сервисов ClickHouse, Vector и Lighthouse на хостах, указанных в файле inventory/prod.yml

### В каталоге vms представлены описания виртуальных машин для развертывания на платформе Yandex Cloud. Для начала установки выполните следующие шаги:

```bash
terraform init
terraform plan
terraform apply
```

### Установка ролей для Ansible

Перед установкой сервисов необходимо установить соответствующие роли с помощью команды:    

```bash
ansible-galaxy install -r requirements.yml -p ./roles
```
### Настройка инвентаря    

Добавьте IP-адреса созданных виртуальных машин в файл inventory/prod.yml, чтобы Ansible знал, на какие хосты устанавливать сервисы.     

```bash
./inventory/prod.yml
```

### Запуск плейбука

После настройки инвентаря выполните следующую команду для запуска плейбука:

```bash
ansible-playbook -i inventory/prod.yml -u centos site.yml
```
### Установка Nginx

Процесс установки Nginx описан в задачах (tasks) в файле site.yml.

Этот playbook упростит процесс установки и настройки стека ClickHouse, Vector и Lighthouse на вашем хосте. Следуйте описанным шагам для успешного развертывания всего стека и начните анализ и визуализацию ваших данных с легкостью.
