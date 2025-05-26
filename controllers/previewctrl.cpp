#include <QRegularExpression>

#include "previewctrl.h"

PreviewCtrl::PreviewCtrl(QObject *parent)
    : QObject(parent)
{}

QString PreviewCtrl::convertToHtml(const QString &markdown)
{
    QString html = markdown;

    // ✅ 先进行 HTML 特殊字符转义，跳过Markdown语法块
    // 这部分转义要小心，只对文本内容进行转义，排除部分Markdown元素
    html.replace("&", "&amp;");
    html.replace("<", "&lt;");
    html.replace(">", "&gt;");
    html.replace("\"", "&quot;");
    html.replace("'", "&#39;");

    // ✅ Markdown 语法替换
    html.replace(QRegularExpression(R"(\*\*(.*?)\*\*)"), R"(<b>\1</b>)");
    html.replace(QRegularExpression(R"(\*(.*?)\*)"), R"(<i>\1</i>)");
    html.replace(QRegularExpression(R"(^###### (.+)$)", QRegularExpression::MultilineOption),
                 R"(<h6>\1</h6>)");
    html.replace(QRegularExpression(R"(^##### (.+)$)", QRegularExpression::MultilineOption),
                 R"(<h5>\1</h5>)");
    html.replace(QRegularExpression(R"(^#### (.+)$)", QRegularExpression::MultilineOption),
                 R"(<h4>\1</h4>)");
    html.replace(QRegularExpression(R"(^### (.+)$)", QRegularExpression::MultilineOption),
                 R"(<h3>\1</h3>)");
    html.replace(QRegularExpression(R"(^## (.+)$)", QRegularExpression::MultilineOption),
                 R"(<h2>\1</h2>)");
    html.replace(QRegularExpression(R"(^# (.+)$)", QRegularExpression::MultilineOption),
                 R"(<h1>\1</h1>)");

    html.replace(QRegularExpression(R"(\[(.*?)\]\((.*?)\))"), R"(<a href="\2">\1</a>)");
    html.replace(QRegularExpression(R"(!\[(.*?)\]\((.*?)\))"), R"(<img alt="\1" src="\2" />)");
    html.replace(QRegularExpression(R"(`(.*?)`)"), R"(<span style="color:blue">\1</span>)");

    html.replace(QRegularExpression(R"(^> (.+)$)", QRegularExpression::MultilineOption),
                 R"(<blockquote>\1</blockquote>)");
    html.replace(QRegularExpression(R"(^(-{3,}|[*]{3,})$)", QRegularExpression::MultilineOption),
                 R"(<hr />)");
    html.replace(QRegularExpression(R"(~~(.*?)~~)"), R"(<del>\1</del>)");
    html.replace(QRegularExpression(R"(==(.*?)==)"), R"(<mark>\1</mark>)");

    // ✅ 列表处理（按行处理更准确）
    QStringList lines = html.split('\n');
    QStringList result;
    bool inUnordered = false;
    bool inOrdered = false;

    for (const QString &line : lines) {
        QRegularExpression todoRe(R"(^\s*-\s+\[ \]\s+(.*))");
        QRegularExpression doneRe(R"(^\s*-\s+\[[xX]\]\s+(.*))");
        QRegularExpression unorderedRe(R"(^\s*[\-\*]\s+(.*))");
        QRegularExpression orderedRe(R"(^\s*\d+\.\s+(.*))");

        QRegularExpressionMatch match;

        if ((match = todoRe.match(line)).hasMatch()) {
            if (!inUnordered)
                result << "<ul>", inUnordered = true;
            result << QString("<li><input type=\"checkbox\"> %1</li>").arg(match.captured(1));
        } else if ((match = doneRe.match(line)).hasMatch()) {
            if (!inUnordered)
                result << "<ul>", inUnordered = true;
            result << QString("<li><input type=\"checkbox\" checked> %1</li>").arg(match.captured(1));
        } else if ((match = unorderedRe.match(line)).hasMatch()) {
            if (!inUnordered)
                result << "<ul>", inUnordered = true;
            result << QString("<li>%1</li>").arg(match.captured(1));
        } else if ((match = orderedRe.match(line)).hasMatch()) {
            if (!inOrdered)
                result << "<ol>", inOrdered = true;
            result << QString("<li>%1</li>").arg(match.captured(1));
        } else {
            if (inUnordered)
                result << "</ul>", inUnordered = false;
            if (inOrdered)
                result << "</ol>", inOrdered = false;
            result << line;
        }
    }

    if (inUnordered)
        result << "</ul>";
    if (inOrdered)
        result << "</ol>";

    html = result.join("\n");

    // ✅ 代码块
    html.replace(QRegularExpression(R"(```(.*?)```)",
                                    QRegularExpression::DotMatchesEverythingOption),
                 R"(<pre><code>\1</code></pre>)");

    // ✅ 数学公式和数学块
    html.replace(QRegularExpression(R"(\$\$(.*?)\$\$)",
                                    QRegularExpression::DotMatchesEverythingOption),
                 R"(<div class="math-block">\1</div>)");
    html.replace(QRegularExpression(R"(\$(.*?)\$)"), R"(<span class="math">\1</span>)");

    // ✅ 表格（非常基础的支持）
    html.replace(QRegularExpression(R"(^\|(.+)\|\n\|[-:\| ]+\|)",
                                    QRegularExpression::MultilineOption),
                 R"(<table><thead><tr><th>\1</th></tr></thead><tbody>)");
    html.replace(QRegularExpression(R"(^\|(.+)\|)", QRegularExpression::MultilineOption),
                 R"(<tr><td>\1</td></tr>)");
    if (html.contains("<table>")) {
        html += "</tbody></table>";
    }

    // ✅ 换行处理
    html.replace(QRegularExpression(R"(\n)"), "<br>");

    // ✅ 返回完整 HTML 结构，设置字体
    return R"(
<html>
<head>
<style>
    body {
        font-family: "AR PL UKai CN", "Noto Serif SC", "KaiTi", "SimSun", "serif";
        font-size: 16px;
        line-height: 1.6;
    }
</style>
</head>
<body>
)" + html + "</body></html>";
}
