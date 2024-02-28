import psutil, sys


def get_info_cpu():
    # 获取CPU的逻辑个数
    cpu_counts = psutil.cpu_count()
    # 获取CPU运行时间 ，可以进一步查看系统运行时间，空闲时间、用户空间运行时间等
    cpu_times = psutil.cpu_times_percent(percpu=True)
    # 获取CPU状态
    cpu_stats = psutil.cpu_stats()

    print("服务区CPU的个数为: {}\nCPU运行时间: {}\nCPU状态: {}".format(cpu_counts, cpu_times, cpu_stats))


def get_mem_info():
    mem = psutil.virtual_memory()
    # 总内存
    total_mem = int(mem.total / 1024 / 1024)
    # 已用内存
    user_mem = int(mem.used / 1024 / 1024)
    # 空闲内存
    free_mem = int(mem.free / 1024 / 1024)
    print("服务器总内存：{}M,\n已用内存: {}M,\n空闲内存: {}M".format(total_mem, user_mem, free_mem))


def get_disk():
    # 要排除的磁盘列表,为空代表全部需要查询
    excluded_disks = ["/dev/sda1"]

    # 获取所有磁盘信息
    disk_info = psutil.disk_partitions()
    for disk in disk_info:
        if disk.device in excluded_disks:
            continue
        try:
            u = psutil.disk_usage(disk.mountpoint)
            print("磁盘: {},\n磁盘大小: {:.2f} GB,\n已用: {:.2f} GB,\n空闲: {:.2f} GB,\n使用率: {:.2f}%".format(
                disk.device, u[0] / 1024 ** 3, u[1] / 1024 ** 3, u[2] / 1024 ** 3, u[3]))
        except Exception as e:
            print(f"获取磁盘信息失败: {e}")


def get_net():
    info = psutil.net_io_counters()
    print(
        "bytes_sent: {}\nbytes_recv: {}\npackets_sent: {}\npackets_reve: {}".format(info[0], info[1], info[2], info[3]))


def get_pid():
    pids = psutil.pids()
    for i in pids:
        print("进程名: {},进程ID: {}，进程状态: {}".format(psutil.Process(i).name, psutil.Process(i).pid,
                                                          psutil.Process(i).status()))


if __name__ == '__main__':
    msg = input("请输入需要查看的系统信息:(cpu|mem|disk|net|pid)")
    if msg:
        if msg == 'cpu':
            get_info_cpu()
        elif msg == 'mem':
            get_mem_info()
        elif msg == 'disk':
            get_disk()
        elif msg == 'net':
            get_net()
        elif msg == 'pid':
            get_pid()
        else:
            print("输入不合法，程序退出")
            sys.exit(1)
    else:
        print("输入为空，程序退出")
        sys.exit(1)