for i in range(3,13):
	constStr = ""
	constStr += 'BSStructure *cn'+str(i)+' = [[BSStructure alloc]initWithName:@"'+'NAME'+'" andType:CRANIALNERVE andColor:[self getColor]];\n'
	constStr += '[cn'+str(i)+' addXMLFilePath:@"'+'XMLNAME'+'" withFillColor:nil];\n'
	constStr += '[CranialNerves addObject:cn'+str(i)+'];\n'
	print(constStr)