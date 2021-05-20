# A Rebeccompany precisa de você!!!

Depois de muito dinheiro gasto com o desenvolvimento do nosso playground revolucionário que transforma qualquer receita em uma **Rebecceita** percebemos o nosso desenvolvedor não sabe criar constraints 😱😱😰.
Sendo assim decidimos desafiar vocês para fazer as constraints para nós e se tiver o estomago para isso uma tela completamente nova 🎉. O desafio funciona em 3 etapas e elas são as seguintes:

## 🥉 Bronze
Execute o layout abaixo dentro da função _addConstraints()_.
![primeira tela](https://github.com/gbrlCM/Desafio-Auto-Layout/blob/main/Resources/Screen1.png)

1. avatar topAnchor |---| view topAnchor + 32
2. avatar centerXAnchor |---| view centerXAnchor
3. avatar heightAnchor |---| 240
4. avatar widthAnchor |---| 240
5. titleLabel topAnchor |---| avatar bottomAnchor + 24
6. titleLabel leadingAnchor |---| view leadingAnchor
7. titleLabel trailingAnchor |---| view trailingAnchor
8. addField topAnchor |---| titleLabel bottomAnchor + 64
9. addField heightAnchor |---| 60
10. addField widthAnchor |---| view widthAnchor * 0.50
11. addField leadingAnchor |---| recipeTable leadingAnchor - 15
12. addButton leadingAnchor |---| addField trailingAnchor + 16
13. addButton topAnchor |---| addField topAnchor
14. addButton bottomAnchor |---| addField bottomAnchor
15. addButton trailingAnchor |---| recipeTable trailingAnchor - 15
16. recipeTable topAnchor |---| addField bottomAnchor + 64
17. recipeTable leadingAnchor |---| view leadingAnchor + 64
18. recipeTable trailingAnchor |---| view trailingAnchor - 64
19. totalLabel topAnchor |---| recipeTable bottomAnchor + 16
20. totalLabel bottomAnchor |---| view bottomAnchor - 16
21. totalLabel centerXAnchor |---| view centerXAnchor

## 🥈 Prata
Execute o mesmo layout usando constraints diferentes.
![segunda tela](https://github.com/gbrlCM/Desafio-Auto-Layout/blob/main/Resources/Screen2.png)

## 🥇 Ouro
Execute essa tela que deve aparecer quando for tocada em qualquer elemento da lista, para carregar imagens diferentes para cada comida usa a função _UIImageView.loadFromUnsplash(_ tag:)_

![terceira tela](https://github.com/gbrlCM/Desafio-Auto-Layout/blob/main/Resources/Screen3.png)
