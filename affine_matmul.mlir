module {
  func.func @_matmul(%arg0: memref<?x?xf64>, %arg1: memref<?x?xf64>, %arg2: memref<?x?xf64>) {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %cst = arith.constant 0.000000e+00 : f64
    %dim = memref.dim %arg2, %c0 : memref<?x?xf64>
    %dim_0 = memref.dim %arg2, %c1 : memref<?x?xf64>
    affine.for %arg3 = 0 to %dim {
      affine.for %arg4 = 0 to %dim_0 {
        affine.store %cst, %arg2[%arg3, %arg4] : memref<?x?xf64>
      }
    }
    %dim_1 = memref.dim %arg0, %c0 : memref<?x?xf64>
    %dim_2 = memref.dim %arg0, %c1 : memref<?x?xf64>
    %dim_3 = memref.dim %arg1, %c1 : memref<?x?xf64>
    affine.for %arg3 = 0 to %dim_1 {
      affine.for %arg4 = 0 to %dim_3 {
        affine.for %arg5 = 0 to %dim_2 {
          %0 = affine.load %arg0[%arg3, %arg5] : memref<?x?xf64>
          %1 = affine.load %arg1[%arg5, %arg4] : memref<?x?xf64>
          %2 = affine.load %arg2[%arg3, %arg4] : memref<?x?xf64>
          %3 = arith.mulf %0, %1 : f64
          %4 = arith.addf %2, %3 : f64
          affine.store %4, %arg2[%arg3, %arg4] : memref<?x?xf64>
        }
      }
    }
    return
  }
  func.func @matmul(%arg0: tensor<?x?xf64>, %arg1: tensor<?x?xf64>) -> tensor<?x?xf64> {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %cst = arith.constant 0.000000e+00 : f64
    %0 = bufferization.to_memref %arg1 : memref<?x?xf64>
    %1 = bufferization.to_memref %arg0 : memref<?x?xf64>
    %2 = bufferization.to_memref %arg1 : memref<?x?xf64>
    %3 = bufferization.to_memref %arg0 : memref<?x?xf64>
    %dim = memref.dim %3, %c0 : memref<?x?xf64>
    %dim_0 = memref.dim %2, %c1 : memref<?x?xf64>
    %alloc = memref.alloc(%dim, %dim_0) {alignment = 64 : i64} : memref<?x?xf64>
    %4 = bufferization.to_tensor %alloc : memref<?x?xf64>
    %dim_1 = tensor.dim %4, %c0 : tensor<?x?xf64>
    %dim_2 = tensor.dim %4, %c1 : tensor<?x?xf64>
    %alloc_3 = memref.alloc(%dim_1, %dim_2) {alignment = 64 : i64} : memref<?x?xf64>
    affine.for %arg2 = 0 to %dim_1 {
      affine.for %arg3 = 0 to %dim_2 {
        affine.store %cst, %alloc_3[%arg2, %arg3] : memref<?x?xf64>
      }
    }
    %alloc_4 = memref.alloc(%dim_1, %dim_2) {alignment = 64 : i64} : memref<?x?xf64>
    memref.copy %alloc_3, %alloc_4 : memref<?x?xf64> to memref<?x?xf64>
    %dim_5 = memref.dim %1, %c0 : memref<?x?xf64>
    %dim_6 = memref.dim %1, %c1 : memref<?x?xf64>
    %dim_7 = memref.dim %0, %c1 : memref<?x?xf64>
    affine.for %arg2 = 0 to %dim_5 {
      affine.for %arg3 = 0 to %dim_7 {
        affine.for %arg4 = 0 to %dim_6 {
          %6 = affine.load %1[%arg2, %arg4] : memref<?x?xf64>
          %7 = affine.load %0[%arg4, %arg3] : memref<?x?xf64>
          %8 = affine.load %alloc_4[%arg2, %arg3] : memref<?x?xf64>
          %9 = arith.mulf %6, %7 : f64
          %10 = arith.addf %8, %9 : f64
          affine.store %10, %alloc_4[%arg2, %arg3] : memref<?x?xf64>
        }
      }
    }
    %5 = bufferization.to_tensor %alloc_4 : memref<?x?xf64>
    return %5 : tensor<?x?xf64>
  }
}

