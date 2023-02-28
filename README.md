# CCCLearning
To lower the code linalg_matmul.mlir to the affine dialect, run the following:
```
mlir-opt --tensor-bufferize --linalg-bufferize --convert-linalg-to-affine-loops linalg_matmul.mlir -o affine_matmul.mlir
```

To lower the code linalg_matmul.mlir to the affine dialect with loop unroll transformation, run the following:
```
mlir-opt --tensor-bufferize --linalg-bufferize --convert-linalg-to-affine-loops --affine-loop-unroll linalg_matmul.mlir -o affine_loop_unroll.mlir
```

To lower the code to llvm (there are some unrealized_conversion_casts that have not been resolved and those cannot be lowered to llvm):
```
./mlir-opt --convert-tensor-to-linalg --tensor-bufferize --linalg-bufferize --convert-linalg-to-affine-loops --affine-loop-unroll --lower-affine --convert-scf-to-cf --convert-cf-to-llvm --finalize-memref-to-llvm --affine-expand-index-ops  --convert-arith-to-llvm --convert-index-to-llvm  linalg_matmul.mlir -o llvm_matmul.mlir
```
