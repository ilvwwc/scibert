# seeds
export SEED=42
export PYTORCH_SEED=42
export NUMPY_SEED=42

# model
export BERT=scibert-base-uncased

# data
export TRAIN_PATH=data/ner/bc5cdr/train.txt
export DEV_PATH=data/ner/bc5cdr/dev.txt
export TEST_PATH=data/ner/bc5cdr/test.txt

# train
export NUM_EPOCHS=30
export BATCH_SIZE=16
export LEARNING_RATE=1e-4
export CUDA_DEVICE=0

# allennlp run
allennlp train \
  --include-package scibert \
  -s expriments/ner \
  training_config/ner.jsonnet
