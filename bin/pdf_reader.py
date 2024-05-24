import os
import sys
import pyperclip
from pdfminer.high_level import extract_text

chatgpt_prompt = """Te pasare el contenido de un pdf en texto y me ayudaras a entenderlo.
Es decir, me brindaras un resumen sobre el articulo. Ten en cuenta que como esta
pasado a texto, no muchas de las oraciones que te estaran tendran sentido debido
a los pies de pagina y demas.

Contenido del PDF: "<pdf>" """

try:
    pdf_file = sys.argv[1]
    if not pdf_file.endswith(".pdf"):
        raise Exception()
    path_pdf = os.path.abspath(pdf_file)
    pdf_content = extract_text(path_pdf)
    chatgpt_prompt = chatgpt_prompt.replace("<pdf>", pdf_content)
    pyperclip.copy(chatgpt_prompt)

except:
    print("Please provide a valid PDF file")
