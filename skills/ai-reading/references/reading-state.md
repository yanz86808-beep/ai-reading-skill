# 阅读状态协议

用于多阶段、跳阶段、多书或自动评估任务。普通一次性报告不必向用户展示完整状态，但内部必须保留足以防止串书和观点倒退的字段。

## 最小状态

```yaml
book:
  id: "作者 + 书名 + 版本或语言"
  type: "方法论 / 商业管理 / 文学 / 历史纪实 / 科学科普 / 哲学思想 / 混合"
reader:
  intent: "应用 / 理解 / 研究 / 文学体验 / 内容创作 / 混合"
  context: "仅记录用户明确提供的信息或标明的通用假设"
  question: "当前阅读问题"
evidence:
  scope: "已获得的原书、节选和公开材料范围"
  verified_claims: []
  unknowns: []
stages:
  stage_1:
    status: "pending / completed / skipped / auto_foundation"
    master_framework: null
  stage_2:
    status: "pending / in_progress / completed / skipped / fixture_completed"
    revision: 0
    tested_concepts: []
    corrected_explanations: []
  stage_3:
    status: "pending / completed / skipped / auto_foundation / stale"
    revision: 0
    based_on_stage_2_revision: null
    revised_claims: []
  stage_4:
    status: "pending / completed / skipped / auto_foundation / stale"
    based_on_stage_3_revision: null
    asset_type: null
    source_claim: null
current_stage: 1
```

字段可以使用自然语言维护，不要求向用户输出 YAML，也不要求将状态写入文件。

## 转移规则

- **继续或下一阶段**：沿用同一 `book.id`、读者映射、证据范围和最近完成结果，只推进 `current_stage`。
- **换书、换版本或换读者**：建立新状态；不得继承上一状态的框架、解释、应用场景或资产。
- **完成或返回阶段二**：每次形成新的纠偏结果都递增 `stage_2.revision`。若阶段三已经基于旧版本完成，将阶段三和阶段四标记为 `stale`；不能继续使用旧版本。
- **进入阶段三**：优先使用最新 `corrected_explanations`；完成后递增 `stage_3.revision`，并把当前 `stage_2.revision` 写入 `based_on_stage_2_revision`。没有阶段二结果时建立最小可信基础并标记 `auto_foundation`，不能伪装成阶段二已完成。
- **进入阶段四**：只有 `stage_3.based_on_stage_2_revision` 等于最新 `stage_2.revision` 时，才能直接使用 `revised_claims`。不相等时先重跑受影响的阶段三；完成资产后把最新 `stage_3.revision` 写入 `based_on_stage_3_revision`。没有阶段三结果时只补齐资产需要的观点、证据和边界，并标记 `auto_foundation`。
- **跳过阶段**：标记 `skipped`，不写成 `completed`；以后可以返回。
- **自动评估**：阶段二使用测试夹具时标记 `fixture_completed`，不得把夹具存入“用户自己的解释”。

## 交付前状态检查

- 当前输出的书名、作者、书型和读者问题是否来自同一状态；
- 阶段三是否使用阶段二的最新修正版；
- 阶段四是否使用阶段三的最新可靠版本；
- 阶段三、四的 `based_on` 版本是否与上游最新版本一致，是否仍有 `stale` 状态；
- 直接进入后续阶段时，自动补齐是否被明确标记；
- 换书后是否残留上一位读者的场景、例子、指标或渠道；
- 被跳过的阶段是否被错误写成已经完成。
