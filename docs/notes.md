# Anotações gerais do projeto

## Atualização de Ruby

Algumas atualizações antes necessitam de upgrade do sistema inteiro e do [ruby-build][ruby-build] (caso seja o rbenv)

Pra atualizar a versão do Ruby usando rbenv é só digitar ```rbenv uninstall``` e seguir as instruçoes para desinstalar o ruby antigo

> Tive um erro dizendo que faltava o ```libyaml``` antes de atualizar o Ruby para o mais atual
Depois de instalar o ```libyaml```, rodei o comando pra instalar o Ruby novamente e rodei normalmente ```rbenv install {VERSION}``` e funcionou normalmente

Depois do problema resolvido, rodei ```rbenv versions``` pra conferir as versões do Ruby instaladas e vi que a versão anterior do Ruby ainda estava apontada. Rodando ```rbenv global {VERSION}``` e ```rbenv local {VERSION}``` para que a nova versão do Ruby fosse reconhecida. Depois disso tudo, mudamos a versão do Ruby no ```Gemfile``` e em ```.ruby-version``` e depois rodamos ```bundle install``` pra atualizar tudo


[ruby-build]: https://github.com/rbenv/ruby-build#installation
