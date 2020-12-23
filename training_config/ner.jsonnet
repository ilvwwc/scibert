{
  "random_seed": std.parseInt(std.extVar("SEED")),
  "pytorch_seed": std.parseInt(std.extVar("PYTORCH_SEED")),
  "numpy_seed": std.parseInt(std.extVar("NUMPY_SEED")),
  "dataset_reader": {
    "type": "conll2003",
    "tag_label": "ner",
    "coding_scheme": "BIOUL",
    "token_indexers": {
      "bert": {
          "type": "pretrained_transformer_mismatched",
          "model_name": std.extVar("BERT"),
      }
    }
  },
  "train_data_path": std.extVar("TRAIN_PATH"),
  "validation_data_path": std.extVar("DEV_PATH"),
  "test_data_path": std.extVar("TEST_PATH"),
  "evaluate_on_test": true,
  "model": {
    "type": "crf_tagger",
    "label_encoding": "BIOUL",
    "constrain_crf_decoding": true,
    "calculate_span_f1": true,
    "dropout": 0.5,
    "include_start_end_transitions": false,
    "text_field_embedder": {
        "token_embedders": {
            "bert": {
                "type": "pretrained_transformer_mismatched",
                "model_name": std.extVar("BERT")
            }
        }
    },
    "encoder": {
        "type": "lstm",
        "input_size": 768,
        "hidden_size": 768 / 2,
        "num_layers": 2,
        "dropout": 0.5,
        "bidirectional": true
    }
  },
  "iterator": {
    "type": "bucket",
    "sorting_keys": [["tokens", "num_tokens"]],
    "batch_size": std.extVar("BATCH_SIZE"),
    "cache_instances": true
  },
  "trainer": {
    "type": "gradient_descent",
    "optimizer": {
        "type": "adam2",
        "lr": std.extVar("LEARNING_RATE")
    },
    "validation_metric": "+f1-measure-overall",
    "num_serialized_models_to_keep": 3,
    "num_epochs": std.parseInt(std.extVar("NUM_EPOCHS")),
    "should_log_learning_rate": true,
    "patience": 10,
    "cuda_device": std.parseInt(std.extVar("CUDA_DEVICE"))
  }
}
