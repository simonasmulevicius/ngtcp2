# Simonas Mulevicius, sm2354@cam.ac.uk

import math

# This code generates index_[SIZE].html files of the specified SIZE
# 
# SIZE is assumed to be in the interval (0, 10 000 000 000)
def generate_html(SIZE_IN_BYTES):
    file_name = "../index_" 
    if (SIZE_IN_BYTES < 0):
        return
    elif (SIZE_IN_BYTES < 1000000):
        file_name += str(SIZE_IN_BYTES/1000) + "kB.html" 
    else:
        file_name += str(SIZE_IN_BYTES/1000000) + "MB.html" 

    f = open("./" + file_name, "w")
  
    HTML_start =  """<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>NGTCP2 Server reply</title>
</head>
<body>
<h1>This is a test message from ngtcp2 Server. </h1>
"""
    HTML_end = """</body></html>"""
    HTML_body_contents = ""
    
    REMAINING_SIZE_IN_BYTES = SIZE_IN_BYTES - len(HTML_start) - len(HTML_end)
    for row_number in range(math.floor(REMAINING_SIZE_IN_BYTES/20)):
        HTML_body_contents += '<p>{:12d}</p>\n'.format(row_number)

    f.write(HTML_start + HTML_body_contents + HTML_end)
    f.close()

generate_html(      100)
generate_html(     1000) #1kB
generate_html(    10000) #10kB
generate_html(   100000) #100kB
generate_html(  1000000) #1MB
generate_html( 10000000) #10MB
generate_html(100000000) #100MB