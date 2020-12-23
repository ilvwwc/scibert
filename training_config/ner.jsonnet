{
  "random_seed": std.parseInt(std.extVar("SEED")),
  "pytorch_seed": std.parseInt(std.extVar("PYTORCH_SEED")),
  "numpy_seed": std.parseInt(std.extVar("NUMPY_SEED")),
  "dataset_reader": {
    "type": "conll2003",
    "tag_label": "ner",
    "coding_scheme": std.extVar("SCHEME"),
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
    "type": "simple_tagger",
    "label_encoding": "BIO",
    "calculate_span_f1": true,
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
  "data_loader": {
    "batch_size": std.parseInt(std.extVar("BATCH_SIZE")),
    "shuffle": true
  },
  "trainer": {
    "type": "gradient_descent",
    "optimizer": {
        "type": "adamw",
        "lr": std.parseJson(std.extVar("LEARNING_RATE")),
    },
    "validation_metric": "+f1-measure-overall",
    "num_epochs": std.parseInt(std.extVar("NUM_EPOCHS")),
    "patience": 10,
    "cuda_device": std.parseInt(std.extVar("CUDA_DEVICE"))
  }
}
