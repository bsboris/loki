---
title: Template Documentation Index
doc_kind: project
doc_function: index
purpose: Корневая навигация по шаблонному memory-bank. Читать сначала, чтобы понять структуру и точки адаптации под конкретный проект.
status: active
audience: humans_and_agents
---

# Documentation Index

Каталог `memory-bank/` содержит переносимый шаблон проектной документации для разработки ПО. После копирования в downstream-репозиторий адаптируй `domain/`, `engineering/` и `ops/` под реальный стек, процессы и ограничения проекта.

Конкретные instantiated примеры вынесены в корневой каталог `examples/`.

## Аннотированный индекс

- [`domain/index.md`](domain/index.md)
  Читать, когда нужно: зафиксировать product context, архитектурные границы и UI-соглашения проекта.

- [`prd/index.md`](prd/index.md)
  Читать, когда нужно: описать продуктовую инициативу между общим problem statement и downstream feature packages.

- [`use-cases/index.md`](use-cases/index.md)
  Читать, когда нужно: зарегистрировать устойчивый пользовательский или операционный сценарий проекта.

- [`ops/index.md`](ops/index.md)
  Читать, когда нужно: описать локальную разработку, окружения, релизы, конфигурацию и runbooks.

- [`engineering/index.md`](engineering/index.md)
  Читать, когда нужно: задать testing policy, coding style, git workflow и границы автономии агента.

- [`dna/index.md`](dna/index.md)
  Читать, когда нужно: проверить SSoT rules, frontmatter contract и governance-правила документации.

- [`flows/index.md`](flows/index.md)
  Читать, когда нужно: создать feature package, провести фичу по lifecycle gates или использовать шаблон.

- [`adr/index.md`](adr/index.md)
  Читать, когда нужно: найти или завести Architecture Decision Record.

- [`features/index.md`](features/index.md)
  Читать, когда нужно: понять, где живут instantiated feature packages.
