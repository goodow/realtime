realtime
========

Google Docs–style collaboration via the use of operational transforms


You may need to put this in your pom.xml or maven user settings.xml:

```xml
<repositories>
  <repository>
    <id>sonatype-nexus-snapshots</id>
    <name>Sonatype Nexus Snapshots</name>
    <url>https://oss.sonatype.org/content/repositories/snapshots</url>
    <releases>
      <enabled>false</enabled>
    </releases>
    <snapshots>
      <enabled>true</enabled>
    </snapshots>
  </repository>
  <repository>
    <id>goodow-realtime</id>
    <name>Goodow Realtime Maven Repository</name>
    <url>https://raw.github.com/goodow/maven/master/repositories/realtime/</url>
    <snapshots>
      <enabled>false</enabled>
    </snapshots>
  </repository>
</repositories>
```
