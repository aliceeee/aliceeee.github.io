---
layout: post
title:  "Jenkins Plugin"
date:   2014-03-28 16:15:29
categories: jenkins plugin
---

Creating a New Plugin (Maven + Eclipse)

if you are more comfortable with Maven, run the following command:
{% highlight sh %}
$ mvn -U org.jenkins-ci.tools:maven-hpi-plugin:create
{% endhighlight %}
This will ask you a few questions, like the groupId (the Maven jargon for the package name) and the artifactId (the Maven jargon for your project name), then create a skeleton plugin from which you can start with. Make sure you can build this:
{% highlight sh %}
$ cd newly-created-directory
$ mvn package
{% endhighlight %}
To build a plugin, run mvn install. This will create the file ./target/pluginname.hpi that you can deploy to Jenkins.
{% highlight sh %}
$ mvn install
{% endhighlight %}
Eclipse users can run the following Maven command to generate Eclipse project files (the custom outputDirectory parameter is used to work around the lack of JSR-269 annotation processor support in Eclipse:)
{% highlight sh %}
$ mvn -DdownloadSources=true -DdownloadJavadocs=true -DoutputDirectory=target/eclipse-classes eclipse:eclipse
{% endhighlight %}
Once this command completes successfully, use "Import..." (under the File menu in Eclipse) and select "General" > "Existing Projects into Workspace". (Do not select "Existing Maven Projects", which takes you to the m2e route)

Reference: [here][jenkins-wiki]



[jenkins-wiki]:	https://wiki.jenkins-ci.org/display/JENKINS/Jenkins+plugin+development+with+Eclipse

