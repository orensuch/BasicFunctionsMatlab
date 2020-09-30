clear all
h=html_creator('test.html');
h.add(h.begin_html);
h.add(h.header('header1',1))
h.add(h.header('header2',2))
h.add(h.paragraph('abcdef'))
h.add(h.picture('reference-negative bleed.png',1))
tabledata={1,2,3;"abc","def",h.picture('reference-negative bleed.png')}
h.add(h.table(tabledata,700));
h.add(h.end_html);
h.write_file;