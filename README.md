# DexHand_Paper_Reading
灵巧手（Dexterous Hand）文献综述项目

## 项目简介
本项目旨在系统地收集、整理和分析灵巧抓取（Dexterous Grasping）领域的相关文献，包括但不限于：
- 灵巧抓取的基础理论和方法
- 基于学习的抓取策略
- 多指灵巧手控制
- 抓取规划与优化
- 实际应用案例

## 项目结构
```
DexGrasp_Paper_Reading/
├── README.md                 # 项目说明文档
├── papers/                   # 笔记存储
│   ├── survey/              # 综述类论文
│   │   └── *.md            # 论文笔记
│   ├── methods/             # 方法类论文
│   │   ├── learning_based/  # 基于学习的方法
│   │   │   └── *.md        # 论文笔记
│   │   ├── optimization/    # 优化方法
│   │   │   └── *.md        # 论文笔记
│   │   └── control/        # 控制方法
│   │       └── *.md        # 论文笔记
│   └── applications/        # 应用类论文
│       └── *.md            # 论文笔记
├── notes/                   # 笔记相关
│   └── templates/          # 笔记模板
└── bibliography/           # 文献管理
    ├── papers.bib         # BibTeX格式的参考文献
    └── papers.csv         # 论文元数据（标题、作者、年份等）
```

## 文献分类方法
论文将按照以下维度进行分类：

研究类型
   - 综述（Survey）
     * 领域综述：灵巧抓取整体发展
     * 方法综述：特定技术路线总结
     * 应用综述：实际应用场景分析
   
   - 方法（Method）
     * 基于学习（Learning-based）
       - 强化学习：策略优化、探索利用
       - 模仿学习：示教学习、行为克隆
       - 迁移学习：跨域迁移、知识迁移
     
     * 基于优化（Optimization-based）
       - 轨迹优化：抓取路径规划
       - 接触点优化：抓取点选择
       - 力优化：抓取力分配
     
     * 基于控制（Control-based）
       - 阻抗控制：柔顺交互
       - 力控制：精确力控
       - 混合控制：多模态控制
   
   - 应用（Application）
     * 工业应用：生产线、装配
     * 服务机器人：家庭服务、医疗
     * 特殊场景：太空、水下

## 文献阅读笔记模板
每篇论文的阅读笔记将包含以下内容：

1. 基本信息
   - 标题
   - 作者
   - 发表时间
   - 期刊/会议
   - 引用次数

2. 核心内容
   - 研究问题
   - 主要方法
   - 创新点
   - 实验结果
   - 局限性

3. 个人思考
   - 方法评价
   - 潜在改进
   - 相关论文
   - 实践建议

## 文献管理方式
1. 使用BibTeX管理参考文献
2. 使用CSV文件记录论文元数据
3. 使用Markdown格式编写阅读笔记
   - 使用`scripts/create_note.sh`脚本创建新笔记
   - 笔记模板位于`notes/templates/paper_template.md`
4. 定期更新文献分类和总结

## 工具使用说明
### 创建阅读笔记
使用`scripts/create_note.sh`脚本可以快速创建新的论文阅读笔记：

1. 基本用法：
```bash
./scripts/create_note.sh "论文标题"
```

2. 使用步骤：
   - 运行脚本后，会显示类别选择菜单
   - 根据论文类型选择对应的类别编号
   - 脚本会自动在对应目录下创建笔记文件
   - 笔记文件名会根据论文标题自动生成

3. 类别选项：
   - 1) 综述 (Survey)
   - 2) 方法 (Method)
     * 2.1) 基于学习 (Learning-based)
     * 2.2) 基于优化 (Optimization-based)
     * 2.3) 基于控制 (Control-based)
   - 3) 应用 (Application)
   - 4) 其他 (Other)

4. 示例：
```bash
# 创建综述类论文笔记
./scripts/create_note.sh "Dexterous Grasping: A Survey"
# 选择类别 1

# 创建基于学习的论文笔记
./scripts/create_note.sh "Learning Dexterous Grasping with Deep Reinforcement Learning"
# 选择类别 2.1
```

## 如何贡献
1. 更新论文笔记
2. 补充文献分类
3. 提出改进建议

## 更新日志
- 2025-05-16: 项目初始化，建立基本结构
