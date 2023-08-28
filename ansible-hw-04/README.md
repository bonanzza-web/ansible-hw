# Установка стека Clickhouse + Vector + Lighthouse    

Данный playbook устанавливает на хосты, используемые в файле inventory/prod.yml, сервисы Clickhouse, Vector, Lighthouse.

### В каталоге vms описаны виртуальные машины для установки на yandex cloud:

```bash
terraform init
terraform plan
terraform apply
```

### Для установки сервисов необходимо установить роли, выполнив команду:

```bash
ansible-galaxy install -r requirements.yml -p ./roles
```
### далее необходимо внести ip адреса созданных машин в файл 

```bash
./inventory/prod.yml
```

### После чего выполните команду:

```bash
ansible-playbook -i inventory/prod.yml -u centos site.yml
```
### Установка nginx описана в task в файле site.yml
