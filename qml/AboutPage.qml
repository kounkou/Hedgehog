import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: aboutPage
    width: parent.width
    height: parent.height - 10
    property string theme: "light"
    color: themeObject.backgroundColor

    ScrollView {
        width: parent.width >> 1
        height: parent.height
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
        ScrollBar.vertical.policy: ScrollBar.AlwaysOff

        Column {
            width: parent.width
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.margins: 10
            spacing: 10

            Rectangle {
                id: header
                width: parent.width
                height: 230
                color: themeObject.buttonColor
                border.width: 1
                border.color: themeObject.buttonBorderColor
                radius: 10

                Column {
                    anchors.fill: parent
                    anchors.margins: 20

                    Text {
                        text: "🦔"
                        font.pixelSize: 50
                        anchors.horizontalCenter: parent.horizontalCenter
                        // font.family: "Noto Color Emoji"
                    }

                    Text {
                        id: headerText
                        text: "About Hedgehog"
                        font.pixelSize: 24
                        color: themeObject.textColor
                        font.bold: true
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    Image {
                        id: qrcode
                        visible: true
                        height: 115
                        width: 115
                        fillMode: Image.PreserveAspectFit
                        source: "Hedgehog-Telegram.jpeg"
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }
            }

            Rectangle {
                width: parent.width
                height: 50
                color: themeObject.buttonColor
                border.width: 1
                border.color: themeObject.buttonBorderColor
                radius: 10

                Text {
                    text: "Why you should use Hedgehog ?"
                    font.pixelSize: 24
                    anchors.centerIn: parent
                    color: themeObject.textColor
                }
            }

            Rectangle {
                width: parent.width // Set the width explicitly
                height: 1450
                color: themeObject.buttonColor
                radius: 10
                anchors.horizontalCenter: parent.horizontalCenter

                TextArea {
                    id: aboutHedgehog
                    width: parent.width // Set the width explicitly
                    height: parent.height
                    font.family: "Courier New"
                    font.pixelSize: 14
                    font.bold: false
                    color: themeObject.textColor
                    textFormat: TextEdit.RichText
                    readOnly: true
                    text: "<strong>1. Foundational Knowledge for Problem-Solving</strong><br>"
                        + "<p>Algorithms and data structures form the foundation of computational problem-solving. Understanding these concepts allows developers to:</p>"
                        + "<ul>"
                        + "<li><strong>Choose efficient solutions:</strong> Not all problems are solved with brute force. Understanding how to select the right algorithm or data structure helps solve problems optimally in terms of time and space.</li>"
                        + "<li><strong>Optimize performance:</strong> AI tools like ChatGPT can assist in generating code, but they cannot always tailor solutions to a specific use case, especially when fine-tuning performance or solving edge cases.</li>"
                        + "</ul>"
                        + "<br>"
                        + "<b>2. Critical Thinking and Analytical Skills</b><br>"
                        + "<p>Learning algorithms and data structures builds critical thinking, teaching you how to break down complex problems and solve them step by step. These skills are transferable to many fields beyond coding.</p>"
                        + "<b>3. AI and ML Rely on Algorithms</b><br>"
                        + "<p>Artificial intelligence, machine learning (ML), and deep learning are based on complex algorithms (like gradient descent, backpropagation, and decision trees). To effectively use AI tools, and especially if you're developing or optimizing AI models, you need a solid understanding of algorithms.</p>"
                        + "<b>4. Tool Limitations and Understanding</b><br>"
                        + "<p>Tools like ChatGPT can assist with code generation, but they are not perfect. They:</p>"
                        + "<ul>"
                        + "<li>May suggest inefficient or incorrect algorithms.</li>"
                        + "<li>Don’t always understand the specifics of your problem or context as deeply as you can. Understanding algorithms and data structures ensures you can spot issues and optimize solutions generated by AI.</li>"
                        + "</ul>"
                        + "<b>5. Tailored Solutions and Real-World Applications</b><br>"
                        + "<p>AI models are great for generating generic code or answering questions, but many real-world applications require highly specific solutions. Knowing data structures and algorithms allows you to:</p>"
                        + "<ul>"
                        + "<li><strong>Build specialized systems:</strong> Systems like databases, operating systems, and high-frequency trading platforms rely heavily on advanced data structures.</li>"
                        + "<li><strong>Debug and maintain:</strong> When systems fail or exhibit performance issues, deep knowledge of the underlying algorithms allows you to diagnose and fix problems quickly.</li>"
                        + "</ul>"
                        + "<b>6. Career and Job Market Relevance</b><br>"
                        + "<p>Interview preparation: Technical interviews for software engineering roles still place a heavy emphasis on algorithmic and data structure knowledge.<br>"
                        + "Understanding legacy systems: Many existing systems and frameworks are built with traditional algorithms and data structures, so this knowledge is essential for maintaining and upgrading them.</p>"
                        + "<b>7. Creative Problem-Solving</b><br>"
                        + "<p>Even with AI-generated code, human creativity is essential for inventing new solutions or combining existing algorithms in innovative ways. Knowing data structures helps you understand the possibilities and limitations, allowing you to come up with creative approaches that tools like ChatGPT cannot.</p>"
                        + "<b>Conclusion</b><br>"
                        + "<p>In an AI-driven world, algorithms and data structures remain critical for optimizing, debugging, and understanding systems at a deeper level. While AI tools can automate many aspects of coding, they cannot replace the fundamental knowledge required to create, understand, and refine complex software solutions effectively.</p>"
                    padding: 10
                    antialiasing: true
                    wrapMode: Text.Wrap
                    background: Rectangle {
                        color: themeObject.textAreaBackgroundColor
                        border.width: 0
                        border.color: themeObject.textAreaBorderColor
                        radius: 10
                    }
                }
            }

            Rectangle {
                width: parent.width
                height: 50
                color: themeObject.buttonColor
                radius: 10
                border.width: 1
                border.color: themeObject.buttonBorderColor

                Text {
                    text: "What is spaced repetition"
                    font.pixelSize: 24
                    anchors.centerIn: parent
                    color: themeObject.textColor
                }
            }

            Rectangle {
                width: parent.width
                height: 1150
                color: themeObject.buttonColor
                radius: 10
                anchors.horizontalCenter: parent.horizontalCenter

                TextArea {
                    id: aboutSpacedRepetition
                    width: parent.width
                    height: parent.height
                    font.family: "Courier New"
                    font.pixelSize: 14
                    font.bold: false
                    color: themeObject.textColor
                    textFormat: TextEdit.RichText
                    readOnly: true
                    text: "<strong>1. What is Spaced Repetition?</strong><br>"
                        + "<p>Spaced repetition is a learning technique that involves reviewing information at increasing intervals. By reviewing material just before you are likely to forget it, spaced repetition strengthens memory retention over time.</p>"
                        + "<ul>"
                        + "<li><strong>Boost long-term retention:</strong> Regularly reviewing material at optimal intervals enhances your ability to remember it for a longer period.</li>"
                        + "<li><strong>Efficient learning:</strong> Spaced repetition allows you to focus on areas where you're struggling while reducing unnecessary review of already mastered topics.</li>"
                        + "</ul>"
                        + "<br>"
                        + "<strong>2. How It Works</strong><br>"
                        + "<p>Spaced repetition is based on the idea that memory fades over time. By strategically spacing out review sessions, learners can reinforce their understanding just as the material starts to fade from memory. This ensures more efficient learning compared to cramming or frequent repetition.</p>"
                        + "<ul>"
                        + "<li><strong>Intervals grow over time:</strong> The intervals between review sessions increase as you successfully recall the information, ensuring that your brain reinforces the memory just before it weakens.</li>"
                        + "<li><strong>Active recall:</strong> Instead of passively reviewing notes, spaced repetition encourages actively recalling information, which is proven to enhance memory retention.</li>"
                        + "</ul>"
                        + "<br>"
                        + "<strong>3. Benefits of Spaced Repetition</strong><br>"
                        + "<p>Spaced repetition has numerous benefits for learners, especially for mastering complex subjects or preparing for exams. It helps:</p>"
                        + "<ul>"
                        + "<li><strong>Prevent information overload:</strong> Rather than cramming, spaced repetition breaks down learning into manageable chunks, reducing stress and cognitive overload.</li>"
                        + "<li><strong>Improve performance:</strong> This method improves retention and performance, especially in areas requiring deep knowledge or long-term memory, such as language learning or complex technical subjects.</li>"
                        + "</ul>"
                        + "<br>"
                        + "<strong>4. Applications of Spaced Repetition</strong><br>"
                        + "<p>Spaced repetition is commonly used in various fields to enhance learning and retention:</p>"
                        + "<ul>"
                        + "<li><strong>Language learning:</strong> Many language learners use spaced repetition to remember vocabulary and grammar rules more effectively.</li>"
                        + "<li><strong>Exam preparation:</strong> Spaced repetition is a powerful tool for students preparing for standardized tests, as it helps them retain key concepts over longer periods.</li>"
                        + "</ul>"
                        + "<br>"
                        + "<strong>Conclusion</strong><br>"
                        + "<p>Spaced repetition is a proven method for enhancing memory and learning efficiency. By reviewing information at strategic intervals, it helps learners retain knowledge over the long term, making it an invaluable tool for mastering any subject.</p>"
                    padding: 10
                    antialiasing: true
                    wrapMode: Text.Wrap
                    background: Rectangle {
                        color: themeObject.textAreaBackgroundColor
                        border.width: 0
                        border.color: themeObject.textAreaBorderColor
                        radius: 10
                    }
                }
            }

            RowLayout {
                spacing: 20
                anchors.horizontalCenter: parent.horizontalCenter

                CustomButton {
                    id: startPractice

                    buttonText: "Start Practicing"
                    page: practicePage
                }

                CustomButton {
                    id: home

                    buttonText: "Go to home"
                    page: welcomePage
                }
            }
        }
    }
}
