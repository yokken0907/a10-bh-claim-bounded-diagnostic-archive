# A10-BH Claim-Bounded Diagnostic Archive v0.2.0

これは、A10 Core v0.2.1 に基づくブラックホール内部再探査の **限定的診断アーカイブ / 専門家ハンドオフ用リポジトリ** です。

これはブラックホール内部の発見、QES検出、特異点解消、beyond-GRの証拠、数値相対論検証、物理候補の採択を主張するものではありません。

## ロック状態

- diagnostic candidate events: `216`
- stable morphology clusters: `2`
- required external assets: `16`
- bound external assets: `0`
- missing external assets: `16`
- external-comparator executions: `0`
- high-fidelity validations: `0`
- physical-entry authorization: `False`
- physical claims: `0`
- accepted physical candidates: `0`

## 論文

論文は以下に格納しています。

- `paper/a10_bh_claim_bounded_diagnostic_archive_v0_2_0.tex`
- `paper/a10_bh_claim_bounded_diagnostic_archive_v0_2_0.pdf`

日付の下に、後からGitHub URLを書き込める空欄を確保しています。

## 現在の正しい位置づけ

ブラックホール内部を発見したのではなく、旧A10運用で切り過ぎていた探索枝を、A10 Core v0.2.1 の下で sandbox diagnostic として再開し、候補マップ・失敗境界・外部比較ハンドオフ条件を整理したものです。

## 検証

```bash
python3 scripts/verify_manifest.py
```

期待出力:

```text
PASS-SOURCE-MANIFEST-VERIFICATION
```
