# OT Real

## Sistema de Tributos (Taxas e Impostos)
O servidor utiliza um modelo de tributos que incide sobre diversas transações financeiras, como depósitos, saques e transferências. Cada operação pode aplicar um percentual de IOF que é distribuído entre o governo federal e os estados. Os cargos de presidente e governador podem ajustar suas respectivas alíquotas com os comandos `/federaltax` e `/statetax`, permitindo que a economia seja regulada pelos jogadores eleitos.

## Sistema de iLVL
Itens podem possuir um valor de *item level* (iLVL) que indica sua qualidade e poder. Equipamentos com iLVL mais alto costumam oferecer atributos melhores, como dano adicional ou resistências extras. O valor é exibido na descrição do item e serve como referência para requisitos ou para processos de melhoria, incentivando a progressão e a busca por itens superiores.

## Sistema de Governo/Eleições
O mundo conta com um sistema político no qual jogadores podem se candidatar a cargos de presidente ou governador. As eleições ocorrem em ciclos e possuem fases de candidatura e votação. Os vencedores obtêm funções administrativas, como definir taxas e promover eventos, oferecendo uma camada social e colaborativa ao servidor.

## Sistema de Magic Protection
Para equilibrar combates e proteger jogadores em situações específicas, existe um sistema de **Magic Protection**. Ele pode reduzir ou anular o dano mágico recebido conforme condições estabelecidas (por exemplo, em áreas seguras ou ao usar certos itens). Essa mecânica incentiva estratégias variadas e cria janelas de segurança durante confrontos mágicos.

## Graphical Interface

A basic Qt-based GUI can start or stop the server and display logs.

### Build

```bash
cmake -B build -DBUILD_GUI=ON
cmake --build build --target canary_gui
```

### Run

```bash
./build/bin/canary_gui
```
