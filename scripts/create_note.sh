#!/bin/bash

# 显示类别选择菜单
show_categories() {
    echo "请选择论文类别："
    echo "1) 综述 (Survey)"
    echo "2) 方法 (Method)"
    echo "   2.1) 基于学习 (Learning-based)"
    echo "   2.2) 基于优化 (Optimization-based)"
    echo "   2.3) 基于控制 (Control-based)"
    echo "3) 应用 (Application)"
    echo "4) 其他 (Other)"
}

# 获取类别路径
get_category_path() {
    case $1 in
        1) echo "papers/survey" ;;
        2.1) echo "papers/methods/learning_based" ;;
        2.2) echo "papers/methods/optimization" ;;
        2.3) echo "papers/methods/control" ;;
        3) echo "papers/applications" ;;
        4) 
            read -p "请输入新的类别名称: " new_category
            echo "papers/$new_category"
            ;;
        *) 
            echo "无效的选择"
            exit 1
            ;;
    esac
}

# 更新CSV文件
update_csv() {
    local title="$1"
    local csv_file="bibliography/papers.csv"
    
    # 如果CSV文件不存在，创建并添加表头
    if [ ! -f "$csv_file" ]; then
        echo "title,authors,year,venue,doi,url,type,method_category,application,keywords,citations,has_code,code_url,dataset,platform,notes,status" > "$csv_file"
    fi
    
    echo "请填写论文信息（直接回车跳过）："
    
    # 读取用户输入
    read -p "作者列表: " authors
    read -p "发表年份: " year
    read -p "期刊/会议: " venue
    read -p "DOI: " doi
    read -p "项目链接: " url
    read -p "研究类型 (survey/method/application): " type
    read -p "方法类别 (learning/optimization/control，多个用逗号分隔): " method_category
    read -p "应用领域: " application
    read -p "关键词 (用逗号分隔): " keywords
    read -p "引用次数: " citations
    read -p "是否有代码 (yes/no): " has_code
    read -p "代码链接: " code_url
    read -p "数据集: " dataset
    read -p "实验平台: " platform
    read -p "阅读笔记链接: " note_url
    read -p "阅读状态 (未读/在读/已读): " status
    
    # 生成笔记链接（相对路径）
    notes="${category_path#papers/}/${filename}.md"
    
    # 构建CSV行，确保所有字段都被双引号包围，并用逗号分隔
    csv_line="\"$title\",\"$authors\",\"$year\",\"$venue\",\"$doi\",\"$url\",\"$type\",\"$method_category\",\"$application\",\"$keywords\",\"$citations\",\"$has_code\",\"$code_url\",\"$dataset\",\"$platform\",\"$note_url\",\"$status\""
    
    # 确保文件以换行符结尾
    if [ -s "$csv_file" ] && [ "$(tail -c 1 "$csv_file")" != "" ]; then
        echo "" >> "$csv_file"
    fi
    
    # 添加到CSV文件
    echo "$csv_line" >> "$csv_file"
    echo "已更新CSV文件"
}

# 更新BibTeX文件
update_bib() {
    local bib_file="bibliography/papers.bib"
    
    echo "请粘贴论文的BibTeX条目（输入END结束）："
    echo "（可以直接从Google Scholar或其他文献管理工具复制）"
    
    # 创建临时文件
    temp_bib=$(mktemp)
    
    # 读取多行输入直到遇到END
    while IFS= read -r line; do
        if [ "$line" = "END" ]; then
            break
        fi
        echo "$line" >> "$temp_bib"
    done
    
    # 如果BibTeX文件不存在，创建它
    if [ ! -f "$bib_file" ]; then
        touch "$bib_file"
    fi
    
    # 添加空行（如果文件不为空）
    if [ -s "$bib_file" ]; then
        echo "" >> "$bib_file"
    fi
    
    # 添加新的BibTeX条目
    cat "$temp_bib" >> "$bib_file"
    
    # 清理临时文件
    rm "$temp_bib"
    
    echo "已更新BibTeX文件"
}

# 检查参数
if [ $# -lt 1 ]; then
    echo "使用方法: $0 <论文标题>"
    echo "示例: $0 'Dexterous Grasping: A Survey'"
    exit 1
fi

# 获取论文标题
title="$1"

# 显示类别菜单
show_categories

# 获取用户选择
read -p "请输入类别编号 (例如: 2.1): " category_choice

# 获取类别路径
category_path=$(get_category_path "$category_choice")

# 确保目录存在
mkdir -p "$category_path"

# 生成文件名（将标题转换为小写，空格替换为下划线）
filename=$(echo "$title" | tr '[:upper:]' '[:lower:]' | tr ' ' '_' | tr -d ':' | tr -d ',')

# 创建笔记文件
template_file="notes/templates/paper_template.md"
note_file="${category_path}/${filename}.md"

# 检查模板文件是否存在
if [ ! -f "$template_file" ]; then
    echo "错误: 模板文件不存在: $template_file"
    exit 1
fi

# 复制模板并替换标题
cp "$template_file" "$note_file"
sed -i "1s/论文标题/$title/" "$note_file"

echo "已创建笔记文件: $note_file"

# 更新CSV和BibTeX文件
update_csv "$title"
update_bib

echo "完成！请编辑笔记文件，填写论文信息。" 