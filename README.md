# CCCLearning
To lower the code linalg_matmul.mlir to the affine dialect, run the following:
```
mlir-opt --tensor-bufferize --linalg-bufferize --convert-linalg-to-affine-loops linalg_matmul.mlir -o affine_matmul.mlir
```

To lower the code linalg_matmul.mlir to the affine dialect with loop unroll transformation, run the following:
```
mlir-opt --tensor-bufferize --linalg-bufferize --convert-linalg-to-affine-loops --affine-loop-unroll linalg_matmul.mlir -o affine_loop_unroll.mlir
```
