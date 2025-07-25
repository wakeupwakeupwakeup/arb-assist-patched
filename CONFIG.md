# CONFIG.md

This file documents every field in `config.toml` used by **arb-assist** for configuring Solana on-chain arbitrage bots (`smb-onchain` and `NotArb`).

---

## 🔌 Connection Settings

| Key           | Type     | Description                                                                  |
| ------------- | -------- | ---------------------------------------------------------------------------- |
| `rpc_url`     | `string` | RPC endpoint used to fetch Solana blockchain data.                           |
| `grpc_url`    | `string` | GRPC endpoint used for streaming transactions (Yellowstone or ThorStreamer). |
| `grpc_token`  | `string` | Optional authentication token for GRPC endpoint.                             |
| `grpc_engine` | `string` | Type of GRPC engine: `"yellowstone"` or `"thor"`.                            |
| `mode`        | `string` | Output mode: `"smb"` (SolanaMevBot), `"na"` (NotArb), or `"both"`.           |
| `port`        | `int`    | Port to serve config files over HTTP. Use `0` to disable.                    |
| `helius_key`  | `string` | Optional Helius API key for dynamic priority fee estimation.                 |

---

## 🔁 DEX Configuration

| Key               | Type      | Description                                                                     |
| ----------------- | --------- | ------------------------------------------------------------------------------- |
| `dexes`           | `array`   | List of DEX program IDs to include in arbitrage (e.g., Raydium, Orca, Meteora). |
| `filter_programs` | `boolean` | If `true`, only include transactions from programs in `arb_programs`.           |
| `arb_programs`    | `array`   | List of on-chain arbitrage programs to monitor (e.g., SMB, NotArb).             |
| `exclude_mints`   | `array`   | List of token mints to exclude (e.g., WSOL, USDC).                              |

---

## 📝 Output Configuration

| Key      | Type     | Description                                                           |
| -------- | -------- | --------------------------------------------------------------------- |
| `output` | `string` | Name of the output config file (`.toml` or `.json` is auto-appended). |

---

## 🕒 Runtime Timing

| Key               | Type  | Description                                                          |
| ----------------- | ----- | -------------------------------------------------------------------- |
| `update_interval` | `int` | Milliseconds between data updates (default: `10000`).                |
| `run_interval`    | `int` | Minimum time in ms between trades per mint after hitting thresholds. |
| `halflife`        | `int` | Half-life in ms for decaying accumulated statistics.                 |

---

## ⚙️ Arb Logic

| Key                 | Type      | Description                                                  |
| ------------------- | --------- | ------------------------------------------------------------ |
| `ignore_filters`    | `boolean` | If `true`, skip filter thresholds and use all arbable mints. |
| `include_token2022` | `boolean` | Whether to include Token-2022 mints in pool discovery.       |

---

## 🎯 Mint Selection

| Key             | Type    | Description                                                         |
| --------------- | ------- | ------------------------------------------------------------------- |
| `mints_to_arb`  | `array` | Number of mints to use in each bundle group. Example: `[2, 2, 2]`.  |
| `mints_to_rank` | `int`   | Total number of ranked mints to maintain (≥ max of `mints_to_arb`). |

---

## 📊 Sorting Strategies

### `intermint_sort_strategy`

Used to rank mints globally.

- `metric`: `profit`, `roi`, `net_volume`, `total_volume`, `liquidity`, etc.
- `direction`: `"ascending"` or `"descending"`

### `pool_sort_strategy`

Used to sort pools within each mint.

- Same format as above.

---

## 🧱 Filter Thresholds

Define multiple filter levels with increasingly strict conditions. Example:

```toml
filter_thresholds = [
  {min_profit = 10_000_000, min_roi = 2, min_txns = 5, min_fails = 1000, min_net_volume = 10_000_000_000, min_total_volume = 10_000_000_000, min_imbalance_ratio = 0.20, max_imbalance_ratio = 0.8, min_liquidity = 0, min_turnover = 0.0, min_volatility = 0.001},
  ...
]
```

| Field                 | Description                                 |
| --------------------- | ------------------------------------------- |
| `min_profit`          | Minimum arbitrage profit in lamports.       |
| `min_roi`             | Minimum ROI (profit/gas fees).              |
| `min_txns`            | Minimum number of successful arbitrages.    |
| `min_fails`           | Maximum tolerated failure count.            |
| `min_net_volume`      | Minimum `abs(buy_volume - sell_volume)`.    |
| `min_total_volume`    | Minimum total trading volume.               |
| `min_imbalance_ratio` | Lower bound on `net_volume / total_volume`. |
| `max_imbalance_ratio` | Upper bound on imbalance.                   |
| `min_liquidity`       | Minimum total liquidity of pools.           |
| `min_turnover`        | Minimum `total_volume / liquidity`.         |
| `min_volatility`      | Minimum price volatility required.          |

---

## 🔁 Strategy Levels

```toml
strategy_levels = [
  {process_delay = 800, max_cu_limit = 600_000, top_pool_num = 3, memo = "arb-assist-lvl0"},
  ...
]
```

| Field           | Description                 |
| --------------- | --------------------------- |
| `process_delay` | Delay before retrying.      |
| `max_cu_limit`  | Max compute units.          |
| `top_pool_num`  | Number of top pools to use. |
| `memo`          | Optional memo string.       |

---

## 📣 Spam Levels

```toml
spam_levels = [
  {spam = true, spam_bundle_groups = [1], min_cu_percentile = 50, max_cu_percentile = 75, min_cu_price = 10000, max_cu_price = 50000, tx_count = 1, cu_strategy = "Random"},
  ...
]
```

| Field                | Description                                          |
| -------------------- | ---------------------------------------------------- |
| `spam`               | Enable spam mode.                                    |
| `spam_bundle_groups` | List of bundle groups.                               |
| `min_cu_percentile`  | Minimum percentile for CU pricing.                   |
| `max_cu_percentile`  | Maximum percentile.                                  |
| `min_cu_price`       | Minimum compute unit price (lamports).               |
| `max_cu_price`       | Max CU price.                                        |
| `tx_count`           | Transactions per burst.                              |
| `cu_strategy`        | Pricing strategy: `Random`, `Linear`, `Exponential`. |

---

## ⚡ Jito Levels

```toml
jito_levels = [
  {jito = true, jito_bundle_groups = [1,2], jito_min_tip = 3000, jito_max_tip = 120000, jito_strategy = "Random", block_engine_strategy = "OneByOne"},
  ...
]
```

| Field                           | Description                |
| ------------------------------- | -------------------------- |
| `jito`                          | Enable Jito bundle.        |
| `jito_bundle_groups`            | Which bundles to use Jito. |
| `jito_min_tip` / `jito_max_tip` | Tip range (lamports).      |
| `jito_strategy`                 | Tip strategy.              |
| `block_engine_strategy`         | `OneByOne` or `AllAtOnce`. |

Other Jito settings:

- `dynamic_jito_tip_mode`: `"parsed"`, `"tipstream"`, or `"none"`
- `jito_min_profit`: Profit threshold to use Jito
- `jito_use_min_profit`: Whether to enforce profit check
- `no_failure_mode`: Ensure all Jito txs succeed (useful for SMB)

---

## 🧪 Advanced Features

| Key              | Description                              |
| ---------------- | ---------------------------------------- |
| `cetiloan`       | Enable flashloan borrowing.              |
| `merge_mints`    | Allow merged-mint spam.                  |
| `base_mint`      | Main trading token (e.g., WSOL or USDC). |
| `aluts_per_mint` | Number of ALUTs per mint.                |
| `aluts`          | Custom ALUTs to use.                     |

---

## ⚙️ NotArb-Specific

```toml
[notarb]
output = "notarb-config"
jvm_args = ["-server", "-Xmx8192m"]
keypair_path = "${DEFAULT_KEYPAIR_PATH}"
protect_keypair = true
threads = 0
meteora_bin_limit = 20
ips_file_path = ""
prefunded_keypairs_path = ""
jito_regions = ["ny", "slc", "london", "frankfurt", "amsterdam", "tokyo", "singapore"]
max_bundle_transactions = 5
borrow_amount = 500_000_000_000
```

---

## 🧩 Optional Loaders

| Section                  | Description                               |
| ------------------------ | ----------------------------------------- |
| `token_accounts_checker` | Configure how token accounts are checked. |
| `blockhash_updater`      | How to update blockhash periodically.     |
| `account_size_loader`    | Helps with batching account data loads.   |
| `market_loader`          | Custom logic for market discovery.        |
| `lookup_table_loader`    | Loader for finding lookup tables.         |

---

For more help or examples, visit: [**https://github.com/capicua4454/arb-assist**](https://github.com/capicua4454/arb-assist)

