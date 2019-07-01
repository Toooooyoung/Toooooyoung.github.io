---
title: "归并排序的递归与非递归实现"
date: 2019-04-21T17:01:26+08:00
tags:
    - merge sort
    - medium
categories:
    - lintcode
    - sort
    - python
type: posts
---

# [Sort Integers ii](https://www.lintcode.com/problem/sort-integers-ii/description)

<!--more-->
## 要点

### 复杂度

<table>
    <tr>
        <th colspan="3">时间复杂度</th>
        <th rowspan="2">空间复杂度</th>
        <th rowspan="2">稳  定  性</th>
    </tr>
    <tr>
        <th>平均情况</th>
        <th>最好情况</th>
        <th>最坏情况</th>
    </tr>
    <tr>
        <td>O(nlog2n)</td>
        <td>O(nlog2n)</td>
        <td>O(nlog2n)</td>
        <td>O(n)</td>
        <td>稳定</td>
    </tr>
</table>


## 解法
### 递归
```python
class Solution:
    """
    @param A: an integer array
    @return: nothing
    """

    def sortIntegers2(self, A):
        if not A or len(A) == 1:
            return A

        self.mergeSort(A, 0, len(A) - 1)
        return A

    def mergeSort(self, A, low, high):
        if low >= high:
            return

        mid = low + (high - low) // 2
        self.mergeSort(A, low, mid)
        self.mergeSort(A, mid+1, high)
        self.mergeArray(A, low, mid, high)

    def mergeArray(self, A, low, mid, high):
        tmpArrary = A[low:high+1]
        i, j, k = 0, mid-low+1, low
        while i <= mid-low and j <= high-low:
            if tmpArrary[i] <= tmpArrary[j]:
                A[k] = tmpArrary[i]
                i += 1
            else:
                A[k] = tmpArrary[j]
                j += 1
            k += 1
        if i > mid-low+1:
            while j <= high-low:
                A[k] = tmpArrary[j]
                j += 1
                k += 1
        if j > high-low:
            while i <= mid - low:
                A[k] = tmpArrary[i]
                i += 1
                k += 1
```

### 非递归
```python
class Solution:
    """
    @param A: an integer array
    @return: nothing
    """

    def sortIntegers2(self, A):
        if not A or len(A) == 1:
            return A

        self.mergeSort(A, 0, len(A) - 1)

    def mergeSort(self, A, low, high):
        stack = [(low, high)]
        while stack:
            group = stack.pop()
            if len(group) == 3:
                self.mergeArray(A, *group)
            else:
                low, high = group
                if low < high:
                    mid = low + (high - low) // 2
                    stack.append((low, mid, high))
                    stack.append((low, mid))
                    stack.append((mid+1, high))

    def mergeArray(self, A, low, mid, high):
        tmpArrary = A[low:high+1]
        i, j, k = 0, mid-low+1, low
        while i <= mid-low and j <= high-low:
            if tmpArrary[i] <= tmpArrary[j]:
                A[k] = tmpArrary[i]
                i += 1
            else:
                A[k] = tmpArrary[j]
                j += 1
            k += 1
        if i > mid-low+1:
            while j <= high-low:
                A[k] = tmpArrary[j]
                j += 1
                k += 1
        if j > high-low:
            while i <= mid - low:
                A[k] = tmpArrary[i]
                i += 1
                k += 1
```