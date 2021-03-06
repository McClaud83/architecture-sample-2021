# Тест архитектуры приложения

## Описание
>Это тестовый проект в котором я постарался совместить несколько подходов при организации iOS-проекта.

Автор: [Тимофеев Денис](dtimofeev@65apps.com)

Огромную помощь оказали:
- [Владимир Шутов](vshutov@65apps.com) и проект "Profee" за объяснение  работы со State + reducer, UseCases + FeedbackLoop.
- [Александр Борисов](aborisov@65apps.com) и проект "Rentality" за объяснение принципа организации модульной архитектуры на основе CocoaPods.
## Постановка задачи
- Написать приложение, которое получит и выведет списком все контакты из google-аккаунта 65apps.
- Для доступа к списку нужно авторизовать пользователя с помощью Google SignIn.
## Тестируемые принципы
- Модульная архитектура проекта с использованием CocoaPods
- Flexible routing
- Clean-архитектура
- Модули на MVVm.
- Состояние (State) модулей на `reducer`-ах
- Юзкейсы (UseCases) с `FeedbackLoop`-ами
- Обновление UI с использованием `Props`
## Документация
Начал заполнять в этом [репозитории](Documentation).
## Особенности
Платформа: iOS 11.x.
Устройства: iPhone, портретная ориентация.
## Используемые зависимости
- pod 'RxSwift', '5.1.2'
- pod 'RxCocoa', '5.1.1'
- pod 'RxDataSources'
- pod 'RxSwiftExt', '5.2.0'
- pod 'RxFeedback', '3.0.0'
- pod 'RxViewController', '1.0.0'
## Резюме
### Плюсы
- Использование CocoaPods хорошо прокачает ваш скилл (вы начнете ~~видеть матрицу~~ понимать `.podspec`-файлы).
- "Flexible routing" все еще работает и обладает всеми своими фишками и болячками.
- State-ы на reducer-ах хорошо сочетаются с юзкейсами и feedabackloop-ами, а также с генерацией props-ов для описания вьюшек.
### Минусы
- Clean-архитектура можно сказать, что не получилась.
- Использование CocoaPods 
	- вносит трудности при использовании статических библиотек
	- ограничивает иерархию папок до простого списка.
	- усложняет процесс добавления файлов в проект
	- вынуждает выполнять `pod install` после каждого изменения в структуре пода или его зависимостях
- "Flexible routing" сохранил свою концепцию, но поменял принцип построения маршрутов из модулей. Решил назвать его "Ω-flexible routing" (Омега).
-  Описание процессов в модулях с помощью Состояний требует определенной подготовки.
- Описание юзкейсов требует ознакомления с основами RxFeedback.


> Written with [StackEdit](https://stackedit.io/).
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTEzMDQ1MzE3MSwtMTE4MzAyODAyMSwtMT
Y1NDM0MzQ4LC0xMjg4MjgwMjk2LDIwNDQyNDkzMl19
-->