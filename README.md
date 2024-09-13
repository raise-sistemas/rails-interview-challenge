# Desafio Rails

## Introdução

Este é um projeto super simples de inscrição em eventos.
Cada evento possui apenas o título e a capacidade de vagas disponíveis.
Cada inscrito informa apenas o seu email e em qual evento deseja se inscrever.

## Desafio

O desafio é criar um bloqueio para que não seja possível de forma alguma, vender mais ingressos (inscrições) do que o evento tem disponível de acordo com a sua capacidade.

Este problema possui uma solução **Júnior** fácil de resolver,
mas estamos interessados na solução **Sênior** que leva em consideração outros fatores como performance, possíveis falhas, concorrência, organização de código, etc.

## Etapas

1. Faça um fork do projeto
2. Resolva o problema localmente com testes
3. Crie um PR com a sua solução
4. Avisar RH que o PR está pronto
5. A conversa continuará pelo review no github

## Restrições

- Não utilizar gems externas.
- Realizar os testes com o framework atual (não Rspec)
- Prazo de 2 dias assim que receber o desafio

## SETUP

O projeto foi criado com os comandos abaixo:

```sh
rails new golden-ticket
cd golden-ticket
bundle add mysql2
rails g scaffold events title:string capacity:integer
rails g scaffold enrollment event:references email:string
rails db:migrate
rails runner 'Event.create!(title: "O Escolhido", capacity: 1)'
rails runner 'Event.create!(title: "Dois é bom", capacity: 2)'
rails runner 'Event.create!(title: "Três é melhor", capacity: 3)'
rails runner 'Event.create!(title: "Éramos 6", capacity: 6)'
rails dev:cache # To perform using local cache on dev mode
rails s
# visitar: http://localhost:3000/enrollments/new
```
