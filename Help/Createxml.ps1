# Set The Formatting
$xmlsettings = New-Object System.Xml.XmlWriterSettings
$xmlsettings.Indent = $true
$xmlsettings.IndentChars = "    "

# Set the File Name Create The Document
$XmlWriter = [System.XML.XmlWriter]::Create("C:\Users\admin\Documents\Git\automatic-updating\Help\YourXML.xml", $xmlsettings)

# Write the XML Decleration and set the XSL
$xmlWriter.WriteStartDocument()
#$xmlWriter.WriteAttributes("package", 'xmlns="http://schemas.microsoft.com/packaging/2011/08/nuspec.xsd"')

# Start the metadata Element
$xmlWriter.WriteStartElement("package")
#$XmlWriter.WriteAttributeString('xmlns', 'http://schemas.microsoft.com/packaging/2011/08/nuspec.xsd')

    # Start the metadata Element
    $xmlWriter.WriteStartElement("metadata")

        $xmlWriter.WriteElementString("id","PackageName")
        $xmlWriter.WriteElementString("title","Package Title")
        $xmlWriter.WriteElementString("version","1.0.0.0")

    $xmlWriter.WriteEndElement() # <-- End <metadata>
$xmlWriter.WriteEndElement() # <-- End <metadata>
# End, Finalize and close the XML Document
$xmlWriter.WriteEndDocument()
$xmlWriter.Flush()
$xmlWriter.Close()