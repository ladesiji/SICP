# -- coding = utf-8 --
"""
换零钱的方式统计
给定50美分、25美分、10美分、5美分、1美分 5种硬币种类，
计算将任意数量金额换成零钱的方式有几种。
此题见 SICP 第一章 1.22节例题。
通过递归求解：
金额a的换成n种硬币的方式=
现金a换成除第一种硬币外的所有其他硬币的方式 + 
现金 a-d 换成所有种类硬币的方式，其中 d 为第一种硬币的面额
"""

def count_change(amount, coins_list):
    if amount == 0:
        return 1
    elif amount < 0 or not coins_list:
        return 0
    else:
        part1 = count_change(amount, coins_list[1:])
        part2 = count_change(amount-coins_list[0], coins_list[:])
    return part1 + part2

us_coins = [1, 5, 10, 25, 50]
print(count_change(100, us_coins))

# 递归的方法简明易懂，但是Python中容易受递归最大深度影响。
# 下面是迭代的方法：


def count_change_iterate(count, coins_list):
    result=[1] + [0] * (count) # 设置结果集
    for coin_value in coins_list: # 控制变量，硬币种类从第一种开始，逐一添加
        for amount in range(coin_value, count+1):  
            # result[amount] 存储未添加当前种类硬币币值时 金额 amount 全部兑换的方式
            # result[amount - coin_value] 为包括当前币值时 金额 amount - coin_value可以兑换的方式
            # 两者相加，则为将 result[amount] 更新为 包括当前币值金额 amount可以兑换的方式
            result[amount] += result[amount - coin_value]
    return result[count]

us_coins = [1, 5, 10, 25, 50]
print(count_change_iterate(100, us_coins))
