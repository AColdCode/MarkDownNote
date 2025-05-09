// markdownconverter.cpp
#include "markdownconverter.h"
#include <QRegularExpression>

MarkdownConverter::MarkdownConverter(QObject *parent)
    : QObject(parent)
{}

QString MarkdownConverter::convertToHtml(const QString &markdown)
{
    QString html = markdown;
    html.replace(QRegularExpression(R"(\*\*(.*?)\*\*)"), R"(<b>\1</b>)"); // **加粗**
    html.replace(QRegularExpression(R"(\*(.*?)\*)"), R"(<i>\1</i>)");     // *斜体*
    html.replace(QRegularExpression(R"(^###### (.+)$)", QRegularExpression::MultilineOption),
                 R"(<h6>\1</h6>)"); //######6级标题
    html.replace(QRegularExpression(R"(^##### (.+)$)", QRegularExpression::MultilineOption),
                 R"(<h5>\1</h5>)"); //#####5级标题
    html.replace(QRegularExpression(R"(^#### (.+)$)", QRegularExpression::MultilineOption),
                 R"(<h4>\1</h4>)"); //####4级标题
    html.replace(QRegularExpression(R"(^### (.+)$)", QRegularExpression::MultilineOption),
                 R"(<h3>\1</h3>)"); //###3级标题
    html.replace(QRegularExpression(R"(^## (.+)$)", QRegularExpression::MultilineOption),
                 R"(<h2>\1</h2>)"); //##2级标题
    html.replace(QRegularExpression(R"(^# (.+)$)", QRegularExpression::MultilineOption),
                 R"(<h1>\1</h1>)");                                                      //#标题
    html.replace(QRegularExpression(R"(\[(.*?)\]\((.*?)\))"), R"(<a href="\2">\1</a>)"); //链接
    html.replace(QRegularExpression(R"(!\[(.*?)\]\((.*?)\))"),
                 R"(<img alt="\1" src="\2" />)");                         //图片
    html.replace(QRegularExpression(R"(`(.*?)`)"),
                 R"(<span style="color:blue">\1</span>)"); // 行内代码

    html.replace(QRegularExpression(R"(^> (.+)$)", QRegularExpression::MultilineOption),
                 R"(<blockquote>\1</blockquote>)"); //引用块
    html.replace(QRegularExpression(R"(^(-{3,}|[*]{3,})$)", QRegularExpression::MultilineOption),
                 R"(<hr />)");                                            //分割线
    html.replace(QRegularExpression(R"(~~(.*?)~~)"), R"(<del>\1</del>)"); //删除线
    html.replace(QRegularExpression(R"(==(.*?)==)"), R"(<mark>\1</mark>)"); //高亮
    // 列表处理（按行处理更准确）
    QStringList lines = html.split('\n');
    QStringList result;
    bool inUnordered = false;
    bool inOrdered = false;

    for (const QString &line : lines) {
        QRegularExpression todoRe(R"(^\s*-\s+\[ \]\s+(.*))");    // 代办
        QRegularExpression doneRe(R"(^\s*-\s+\[[xX]\]\s+(.*))"); // 已完成
        QRegularExpression unorderedRe(R"(^\s*[\-\*]\s+(.*))");  // 无序
        QRegularExpression orderedRe(R"(^\s*\d+\.\s+(.*))");     // 有序

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

    html.replace(QRegularExpression(R"(```(.*?)```)",
                                    QRegularExpression::DotMatchesEverythingOption),
                 R"(<pre><code>\1</code></pre>)"); //代码块

    html.replace(QRegularExpression(R"(\$(.*?)\$)"),
                 R"(<span class="math">\1</span>)"); //数学公式

    html.replace(QRegularExpression(R"(\$\$(.*?)\$\$)",
                                    QRegularExpression::DotMatchesEverythingOption),
                 R"(<div class="math-block">\1</div>)"); //数学公式块

    // 表格标题行
    html.replace(QRegularExpression(R"(^\|(.+)\|\n\|[-:\| ]+\|)",
                                    QRegularExpression::MultilineOption),
                 R"(<table><thead><tr><th>\1</th></tr></thead><tbody>)");

    // 表格行
    html.replace(QRegularExpression(R"(^\|(.+)\|)", QRegularExpression::MultilineOption),
                 R"(<tr><td>\1</td></tr>)");

    // 表格末尾闭合（你可以查找最后一个 <td> 之后加 </tbody></table>，或者用更精细的方法判断）
    if (html.contains("<table>")) {
        html += "</tbody></table>";
    }

    html.replace(QRegularExpression(R"(\n)"), "<br>"); //回车

    return "<html><body>" + html + "</body></html>";
}
