#map = affine_map<()[s0] -> ((s0 floordiv 4) * 4)>
#map1 = affine_map<(d0) -> (d0 + 1)>
#map2 = affine_map<(d0) -> (d0 + 2)>
#map3 = affine_map<(d0) -> (d0 + 3)>
module {
  func.func @_matmul(%arg0: memref<?x?xf64>, %arg1: memref<?x?xf64>, %arg2: memref<?x?xf64>) {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %cst = arith.constant 0.000000e+00 : f64
    %dim = memref.dim %arg2, %c0 : memref<?x?xf64>
    %dim_0 = memref.dim %arg2, %c1 : memref<?x?xf64>
    affine.for %arg3 = 0 to %dim {
      affine.for %arg4 = 0 to #map()[%dim_0] step 4 {
        affine.store %cst, %arg2[%arg3, %arg4] : memref<?x?xf64>
        %0 = affine.apply #map1(%arg4)
        affine.store %cst, %arg2[%arg3, %0] : memref<?x?xf64>
        %1 = affine.apply #map2(%arg4)
        affine.store %cst, %arg2[%arg3, %1] : memref<?x?xf64>
        %2 = affine.apply #map3(%arg4)
        affine.store %cst, %arg2[%arg3, %2] : memref<?x?xf64>
      }
      affine.for %arg4 = #map()[%dim_0] to %dim_0 {
        affine.store %cst, %arg2[%arg3, %arg4] : memref<?x?xf64>
      }
    }
    %dim_1 = memref.dim %arg0, %c0 : memref<?x?xf64>
    %dim_2 = memref.dim %arg0, %c1 : memref<?x?xf64>
    %dim_3 = memref.dim %arg1, %c1 : memref<?x?xf64>
    affine.for %arg3 = 0 to %dim_1 {
      affine.for %arg4 = 0 to %dim_3 {
        affine.for %arg5 = 0 to #map()[%dim_2] step 4 {
          %0 = affine.load %arg0[%arg3, %arg5] : memref<?x?xf64>
          %1 = affine.load %arg1[%arg5, %arg4] : memref<?x?xf64>
          %2 = affine.load %arg2[%arg3, %arg4] : memref<?x?xf64>
          %3 = arith.mulf %0, %1 : f64
          %4 = arith.addf %2, %3 : f64
          affine.store %4, %arg2[%arg3, %arg4] : memref<?x?xf64>
          %5 = affine.apply #map1(%arg5)
          %6 = affine.load %arg0[%arg3, %5] : memref<?x?xf64>
          %7 = affine.load %arg1[%5, %arg4] : memref<?x?xf64>
          %8 = affine.load %arg2[%arg3, %arg4] : memref<?x?xf64>
          %9 = arith.mulf %6, %7 : f64
          %10 = arith.addf %8, %9 : f64
          affine.store %10, %arg2[%arg3, %arg4] : memref<?x?xf64>
          %11 = affine.apply #map2(%arg5)
          %12 = affine.load %arg0[%arg3, %11] : memref<?x?xf64>
          %13 = affine.load %arg1[%11, %arg4] : memref<?x?xf64>
          %14 = affine.load %arg2[%arg3, %arg4] : memref<?x?xf64>
          %15 = arith.mulf %12, %13 : f64
          %16 = arith.addf %14, %15 : f64
          affine.store %16, %arg2[%arg3, %arg4] : memref<?x?xf64>
          %17 = affine.apply #map3(%arg5)
          %18 = affine.load %arg0[%arg3, %17] : memref<?x?xf64>
          %19 = affine.load %arg1[%17, %arg4] : memref<?x?xf64>
          %20 = affine.load %arg2[%arg3, %arg4] : memref<?x?xf64>
          %21 = arith.mulf %18, %19 : f64
          %22 = arith.addf %20, %21 : f64
          affine.store %22, %arg2[%arg3, %arg4] : memref<?x?xf64>
        }
        affine.for %arg5 = #map()[%dim_2] to %dim_2 {
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
      affine.for %arg3 = 0 to #map()[%dim_2] step 4 {
        affine.store %cst, %alloc_3[%arg2, %arg3] : memref<?x?xf64>
        %6 = affine.apply #map1(%arg3)
        affine.store %cst, %alloc_3[%arg2, %6] : memref<?x?xf64>
        %7 = affine.apply #map2(%arg3)
        affine.store %cst, %alloc_3[%arg2, %7] : memref<?x?xf64>
        %8 = affine.apply #map3(%arg3)
        affine.store %cst, %alloc_3[%arg2, %8] : memref<?x?xf64>
      }
      affine.for %arg3 = #map()[%dim_2] to %dim_2 {
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
        affine.for %arg4 = 0 to #map()[%dim_6] step 4 {
          %6 = affine.load %1[%arg2, %arg4] : memref<?x?xf64>
          %7 = affine.load %0[%arg4, %arg3] : memref<?x?xf64>
          %8 = affine.load %alloc_4[%arg2, %arg3] : memref<?x?xf64>
          %9 = arith.mulf %6, %7 : f64
          %10 = arith.addf %8, %9 : f64
          affine.store %10, %alloc_4[%arg2, %arg3] : memref<?x?xf64>
          %11 = affine.apply #map1(%arg4)
          %12 = affine.load %1[%arg2, %11] : memref<?x?xf64>
          %13 = affine.load %0[%11, %arg3] : memref<?x?xf64>
          %14 = affine.load %alloc_4[%arg2, %arg3] : memref<?x?xf64>
          %15 = arith.mulf %12, %13 : f64
          %16 = arith.addf %14, %15 : f64
          affine.store %16, %alloc_4[%arg2, %arg3] : memref<?x?xf64>
          %17 = affine.apply #map2(%arg4)
          %18 = affine.load %1[%arg2, %17] : memref<?x?xf64>
          %19 = affine.load %0[%17, %arg3] : memref<?x?xf64>
          %20 = affine.load %alloc_4[%arg2, %arg3] : memref<?x?xf64>
          %21 = arith.mulf %18, %19 : f64
          %22 = arith.addf %20, %21 : f64
          affine.store %22, %alloc_4[%arg2, %arg3] : memref<?x?xf64>
          %23 = affine.apply #map3(%arg4)
          %24 = affine.load %1[%arg2, %23] : memref<?x?xf64>
          %25 = affine.load %0[%23, %arg3] : memref<?x?xf64>
          %26 = affine.load %alloc_4[%arg2, %arg3] : memref<?x?xf64>
          %27 = arith.mulf %24, %25 : f64
          %28 = arith.addf %26, %27 : f64
          affine.store %28, %alloc_4[%arg2, %arg3] : memref<?x?xf64>
        }
        affine.for %arg4 = #map()[%dim_6] to %dim_6 {
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

