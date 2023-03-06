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

### Query parameters

Em [welcome_controller.rb](/app/controllers/welcome_controller.rb), podemos ver um uso de uma variável de instância e de sessão.

```ruby
@flash = params[:god_speed]
```

Essa variável de instância `@flash` está recebendo o valor de um Hash. Esse hash é criado no momento em que executamos, por exemplo: `http://{PORT}/?god_speed=Flash` no navegador. O valor da chave `god_speed` é pode ser recuperado pela variável `@flash`

```ruby
Parameters: {"god_speed"=>"Flash", "god_light"=>"Hal Jordan"}
```

Pra enviar informações para mais de uma variável parametrizada, podemos usar:
`http://{PORT}/?god_speed=Flash&god_light=Hal Jordan`

### Partials templates (Layouts and Rendering)

Como se fosse uma herança de partes de outras views.
Por exemplo, ao criar a view [_menu.html.erb](/app/views/welcome/_menu.html.erb), podemos chamar esta view em diversas outras views utilizando o Helper `render`

```erb
<%= render 'menu' %>
```

Dá pra ver esse processo na base da aplicação acessando [_form.html.erb](/app/views/coins/_form.html.erb) e vendo o uso de `_form` dentro de [edit.html.erb](/app/views/coins/edit.html.erb)

Uma parte desse processamento mostra como se comporta o Helper `render`:

```bash
Rendering welcome/index.html.erb within layouts/application
Rendered welcome/_menu.html.erb (Duration: 0.2ms | Allocations: 169)
Rendered welcome/_instances.html.erb (Duration: 0.3ms | Allocations: 197)
Rendered welcome/index.html.erb within layouts/application (Duration: 1.4ms | Allocations: 773)
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

### Pry-Rails

Saindo do ambiente de teste, foi instalado o `pry-rails` através de `gem install pry-rails`, consegui testar cada Coin da Crypto_Wallet utilizando `bin/rails c` e depois `Coin.first` ou `Coin.all` e o resultado será parecido com isso:

```ruby
#<Coin:0x00007f142cf478c8
 id: 3,
 description: "Bitcoin",
 acronym: "BTC",
 url_image: "https://bitcoin.org/img/icons/opengraph.png?1671880122",
 created_at: Sun, 08 Jan 2023 04:43:20.033366000 UTC +00:00,
 updated_at: Sun, 08 Jan 2023 04:43:24.086762000 UTC +00:00>
```

Se quisermos criar uma nova `Coin` através do IRB usando `pry-rails`, podemos criar um novo objeto e associá-lo a uma variável.

> Ao digitar `Coin.` no Pry, podemos apertar TAB duas vezes e receber uma lista de possibilidades do que fazer com este comando. Pra sair do pry, precisamos ir até `(END)` e digitar `Q`

Por exemplo, usando `new_coin = Coin.new`, poderemos então configurar [cada parametro desta nova `Coin`][coins_controller] na mão, usando: `new_coin.description = "Moeda Qualquer"` e assim por diante, pra cada parametro. Para salvar, utiliza-se `new_coin.save!`.

> Outra forma de criar uma nova `Coin` seria utilizando o comando `.create!`. Ficaria `new_coin = Coin.create!()` essa forma economiza digitação, pois podemos settar os dados dos parâmetros da moeda dentro do método, por exemplo `new_coin = Coin.create!( descripction: "Moeda Fulana", acronym: "MOEF" )`

Para testar código sem modificar o banco de dados, temos o

```bash
bin/rails console --sandbox
```

ou

```bash
bin/rails c --sandbox
```

## Gemfile

A fim de padronizar as gems de configuração do VSCode, vou deixar aqui as Gems adicionais e padrão da configuração atual:

```ruby
gem "rubocop", "~> 1.44", group: :development

gem "rubocop-shopify", "~> 2.12", group: :development

gem "solargraph", "~> 0.48.0", group: :development

gem "htmlbeautifier", "~> 1.4", group: :development

gem "pry-rails", "~> 0.3.9", group: :development
```

São instaladas usando, por exemplo `bundle add pry-rails --group "development"`

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
[coins_controller]: app/controllers/../../../app/controllers/coins_controller.rb
