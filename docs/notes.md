# Anotações gerais do projeto

## ERB

Dá pra fazer mistura de HTML com Ruby usando `<%= %>` no meio das marcações.

```erb
<p>Tentando uma multiplicação com ERB: 2 * 5 = <%= 2 * 5 %> </p>

<p>Meu nome de trás pra frente: <%= "Henrique".reverse %> </p>

<% a = "Uma variável qualquer" %>

<p>Imprimindo a variável qualquer: <%= a %></p>

<p>A data de hoje é: <%= Date.today %> </p>
```

Nas configurações das Views, tem como chamar outra view utilizando seu path, como podemos ver em abaixo

```erb
<ul>
 <a href="/coins">Cadastro de Moedas</a>
</ul>
```

Podemos simplificar o código acima [usando Ruby][welcome_index]

```erb
<%= link_to "Cadastro de Moedas", "/coins" %>
```

Para saber as informações do Path que precisa ser chamado, utiliza-se a URL com `http://{PORT}/rails/info/routes` no final, para poder checar o path do caminho desejado. Digitar `rails routes` no terminal também leva ao mesmo resultado.

Há a possibilidade de, por exemplo, fazer com que as imagens cadastradas via URL nos [forms de cadastros, dentro do container de 'url_image'][form_erb] aparecerem ao editar uma coin, usando

```erb
<%= image_tag coin.url_image, size:"30x30" %>
```

Algumas formas de settar o tamanho da imagem:

- Usando tag `img`

```erb
<img src="<%= coin.url_image %>" width="50" height="50" />
```

- Escrevendo as larguras com ERB (`image_tag` resume toda a tag `img` acima)

```erb
<%= image_tag coin.url_image, width: 30, height: 30 %>
```

- Ou, simplificando:

```erb
<%= image_tag coin.url_image, size:"30x30" %>
```

## Helpers

No projeto, precisei recuperar a data atual com formato brasileiro. Poderíamos ter feito isso mesclando Ruby com HTML da seguinte forma

```erb
<p> <strong>Data: </strong> <%= Date.today.strftime("%d/%m/%Y") %> </p>
```

Porém, é mais fácil escrever isso no [helper][aplication_helper], tornando possível [chamar o formatador][welcome_index] em toda aplicação, usando

```ruby
brazilian_date(Date.today)
```

## Routes

No Rails a atribuição da palavra `resources` a algum elemento ou objeto da página faz com que sejam gerados os verbos HTTP relacionados a ele, por exemplo

```ruby
resources :coins
```

Depois do uso da instrução acima em [routes.rb][routes], `coins` ganha 7 verbos HTTP, além das padrão `GET`, `POST`, `PUT` e `DELETE`.

## Rails console

Pra testar os códigos da aplicação, numa espécie de terminal IRB, temos o

```bash
bin/rails console
```

ou

```bash
bin/rails c
```

Existem alguns [objetos que auxiliam no acesso aos códigos][rails_console_objects] na hora da testagem.

Com esse conhecimento, conseguimos resposta ao testar, por exemplo [o helper criado][aplication_helper] `helper.brazilian_date(Date.today)`.

No caso do comando `app.`, consegui testá-lo apenas em ambiente de teste mesmo, rodando o comando abaixo, que faz com que seja carregando um ambiente padrão

```bash
bin/rails c -e test
```

> Os testes com o `bin/rails console` podem modificar o banco de dados, dependendo do teste

Para testar código sem modificar o banco de dados, temos o

```bash
bin/rails console --sandbox
```

ou

```bash
bin/rails c --sandbox
```

<details>
<summary>

> Como estou estudando o asdf, muito provavelmente estas notas abaixo estarão obsoletas, mas vou deixar escrito mesmo assim caso alguém esteja passando pela mesma coisa

</summary>

### Atualização de Ruby

Algumas atualizações antes necessitam de upgrade do sistema inteiro e do [ruby-build][ruby-build] (caso seja o rbenv)

Pra atualizar a versão do Ruby usando rbenv é só digitar `rbenv uninstall` e seguir as instruçoes para desinstalar o ruby antigo

> Tive um erro dizendo que faltava o `libyaml` antes de atualizar o Ruby para o mais atual
> Depois de instalar o `libyaml`, rodei o comando pra instalar o Ruby novamente e rodei normalmente `rbenv install {VERSION}` e funcionou normalmente

Depois do problema resolvido, rodei `rbenv versions` pra conferir as versões do Ruby instaladas e vi que a versão anterior do Ruby ainda estava apontada. Rodando `rbenv global {VERSION}` e `rbenv local {VERSION}` para que a nova versão do Ruby fosse reconhecida. Depois disso tudo, mudamos a versão do Ruby no `Gemfile` e em `.ruby-version` e depois rodamos `bundle install` pra atualizar tudo

</details>

[rails_console_objects]: https://guides.rubyonrails.org/command_line.html#the-app-and-helper-objects
[aplication_helper]: app/../../app/helpers/application_helper.rb
[form_erb]: app/views/coins/../../../../app/views/coins/_form.html.erb
[welcome_index]: app/views/../../../app/views/welcome/index.html.erb
[routes]: app/config/../../../config/routes.rb
[ruby-build]: https://github.com/rbenv/ruby-build#installation
