func.func @matmul(%arg0: memref<?xf32>,
             %arg1: memref<?xf32>,
             %arg2: memref<?x?xf32>) {
  linalg.vecvec
    ins(%arg0, %arg1: memref<?xf32>,
                      memref<?xf32>)
    outs(%arg2: memref<?x?xf32>)
  return
}
