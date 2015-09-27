<?php
ob_start();

$css = glob('*.css'); $css = $css[0];
$js  = glob('*.js');  $js  = $js[0];
$asc = 'emily-2.asc';

?>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <title>Emily L. Shepherd</title>
    
    <!-- Styling -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no" />
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Karla" />
    <link rel="stylesheet" href="/<?=$css?>" />
    
    <meta name="description" content="Hi, I'm Emily. I am a 4th Computer Science student at the University of Southampton, on track for first class honours." />
    <meta name="keywords" content="Web Developer, Computer, HTML, CSS, PHP, Python, JavaScript, JS, Apache, HTTP" />
    <meta name="author" content="Emily Shepherd" />
    <link rel="author" href="https://plus.google.com/111629088428160104525/">
    <link rel="sitemap" href="/sitemap.xml" />
    <link rel="author" href="/humans.txt" />
    <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon" />
    
    <!-- Facebook Open Graph -->
    <meta property="og:description" content="22. UK. Computer Scientist, Web Developer and fourth year undergraduate at the University of Southampton. Contact me at emily@emilyshepherd.me. PGP: 4C8D 7CBA A377 7A9B B0C3 F6FC A91F 7111 D9AF 0B5D" />
    <meta property="og:title" content="Hi, I'm Emily L. Shepherd." />
    <meta property="og:image" content="http://emilyshepherd.me/images/fb_bg.png" />
    <meta property="og:url" content="https://emilyshepherd.me/" />
    
    <!-- Twitter -->
    <meta name="twitter:card" content="summary" />
    <meta name="twitter:site" content="@EmilyLShepherd" />
    <meta name="twitter:title" content="Hi, I'm Emily L. Shepherd." />
    <meta name="twitter:description" content="22. UK. Computer Scientist, Web Developer and fourth year undergraduate at the University of Southampton. Contact me at emily@emilyshepherd.me" />
    <meta name="twitter:image" content="http://emilyshepherd.me/images/me.jpg" />
  </head>
  <body>
    <nav id="top">
      <!-- Links -->
      <div id="linkHolder">
        <a href="#hi"><span>Hi</span></a>
        <a href="#intro"><span>Intro</span></a>
        <a href="#experience"><span>Experience & Portfolio</span></a>
        <a href="#skills"><span>Skills</span></a>
        <a href="#education"><span>Education</span></a>
        <a href="#awards"><span>Awards</span></a>
        <a href="#volunteering"><span>Volunteering</span></a>
        <a href="#casual"><span>Casual Em</span></a>
      </div>
    </nav>
    
    <!-- Menu Button (for mobiles) -->
    <label for="menu">&nbsp;</label>
    <input type="checkbox" id="menu" onclick="closePopup()" />
    <div class="coverAll" onclick="document.getElementById('menu').checked=false;"></div>
    
    <span id="sectionTitle">Emily Shepherd</span>

    <!-- Links -->
    <div id="menuBar">
      <a href="#hi"><span>Hi</span></a>
      <a href="#intro"><span>Intro</span></a>
      <a href="#experience"><span>Experience & Portfolio</span></a>
      <a href="#skills"><span>Skills</span></a>
      <a href="#education"><span>Education</span></a>
      <a href="#awards"><span>Awards</span></a>
      <a href="#volunteering"><span>Volunteering</span></a>
      <a href="#casual"><span>Casual Em</span></a>
    </div>
    
    <!-- Content -->
    <main id="hi">
      
      <!-- Hi, I'm Emily. -->
      <section id="name_section" class="" data-parallax-scale="0.8">
        <div class="inner">
          <img src="/images/me.png" alt="Emily Shepherd" id="me" />
          <img src="/images/me.png" alt="Emily Shepherd" id="meHolder" />
          <div class="bg parallax2" id="php_text" data-parallax-scale="0.8">
            &lt;?php <br />
            <br />
            echo "Hi, I'm Emily.";
          </div>
          <div class="bg parallax2" id="java_text" data-parallax-scale="0.6">
            public class Main                                             <br />
            {                                                             <br />                                              
            &nbsp;&nbsp;&nbsp;&nbsp;public static void main(String[] args)<br />
            &nbsp;&nbsp;&nbsp;&nbsp;{                                     <br />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;System.out.println("Hi, I'm Emily."); <br />
            &nbsp;&nbsp;&nbsp;&nbsp;}                                     <br />
            }
          </div>
          <div class="bg parallax2" id="smtp_text" data-parallax-scale="0.4">
            220 smtp.emilyshepherd.me                                     <br />
            EHLO Hi, I'm Emily.                                           <br />                                              
            250 smtp.emilyshepherd.me
          </div>
          <div class="bg parallax2" id="c_text" data-parallax-scale="0.9">
            #include &lt;stdio.h&gt;                                      <br />
                                                                          <br />                                              
            int main()                                                    <br />
            {                                                             <br />
            &nbsp;&nbsp;&nbsp;&nbsp;printf("Hi, I'm Emily.\n");           <br />
            }
          </div>
          <div class="bg parallax2" id="js_text" data-parallax-scale="0.2">
            document.write("Hi, I'm Emily.");
          </div>
          <div class="bg parallax2" id="cpp_text" data-parallax-scale="0.7">
            #include &lt;iostream.h&gt;                                   <br />
                                                                          <br />                                              
            int main()                                                    <br />
            {                                                             <br />
            &nbsp;&nbsp;&nbsp;&nbsp;cout &lt;&lt; "Hi, I'm Emily." &lt;&lt; endl<br />
            &nbsp;&nbsp;&nbsp;&nbsp;return 0;                             <br />
            }
          </div>
          <div class="bg parallax2" id="css_text" data-parallax-scale="0.4">
            h1:before                                                     <br />
            {                                                             <br />
            &nbsp;&nbsp;&nbsp;&nbsp;content: "Hi, I'm Emily.";            <br />
            }
          </div>
          <div class="bg parallax2" id="dom_text" data-parallax-scale="0.8">
            var el = document.createElement('h1');                        <br />
            el.innerText = 'Hi, I\'m Emily.';                             <br />
            document.appendChild(el);
          </div>
          <div class="bg parallax2" id="xml_text" data-parallax-scale="-0.2">
            &lt;?xml version="1.0" standalone="yes" ?&gt;                 <br />
            &lt;!DOCTYPE greeting [                                       <br />
            &nbsp;&nbsp;&nbsp;&nbsp;&lt;!ELEMENT greeting (#PCDATA)&gt;   <br />
            &nbsp;&nbsp;&nbsp;&nbsp;&lt;!ATTLIST greeting lang CDATA #REQUIRED&gt;<br />
            ]&gt;                                                         <br />
            &lt;greeting lang="en"&gt;Hi, I'm Emily.&lt;/greeting&gt;
          </div>
          <header class="parallax2" data-parallax-scale="0.5">
            <h1>Hi, I'm Emily.</h1>
            <p>Web Developer | Computer Science Undergraduate</p>
          </header>
        </div>
      </section>
      
      <!-- ///////////////////////////////////////////////////////// -->
      
      <section id="intro_section" class="band">
        <h1 id="intro">Let me Introduce Myself</h1>
        <p>
          I am a 4<sup>th</sup> year <a href="#uni">Computer Science student</a> at the University of Southampton, on track for
          first class honours. The degree has introduced me to a
          plethora of concepts and subject areas, including: Low Level Graphics, Compiler
          Engineering, Database Design, Operating Systems and Memory Allocation, to name but a few.
        </p>
        
        <p>
          Outside of the course I work as a <a href="#sweeb">freelance web developer</a> and have
          built and managed sites for a variety of non-profit groups, such as theatre groups,
          local residents associations and charities, and also commercial
          organisations such as <a href="#spastaff">Spa Staff.com</a>,
          <a href="#musicjobs">UK Music Jobs</a> and Simply D'nA.
        </p>
        
        <p>
          When not coding, I like to exercise by hill walking, a
          passion I have loved since completing the Gold Duke of Edinburgh Award. I have also been
          heavily involved in the Students' Union, acting as a course representative,
          running the Nightline Listening Service and fighting for trans* rights.
        </p>
      </section>
      
      <!-- ///////////////////////////////////////////////////////// -->
      
      <section id="experience_section">
        <div id="exp_bg" class="parallax2" data-parallax-scale="0.8" data-parallax-staple="experience_section"></div>
        <h1 id="experience">Experience &amp; Portfolio</h1>
        
        <section id="spastaff">
          <div class="pic_area">
            <img src="/images/spastaff.png" alt="Spa Staff.com Ltd" />
          </div>
          <header>
            <h2>Spa Staff</h2>
            <span class="position">Web Developer and Web Mistress</span>
            <span class="dates">2011 - Present</span>
          </header>
          
          <p>
            I took over the management of
            <a href="https://www.spastaff.com/" target="_blank">Spa Staff.com</a>
            from a professional web
            construction company in 2011, while I was still in Sixth Form. Since
            then, I have been solely in charge of the technical administration
            and development of the site. The site is hosted on an EC2 instance
            in Amazon's Elastic Cloud.
          </p>
          
          <p>
            As web developer, I was responsible for implementing a redesign, from
            their
            <a href="http://web.archive.org/web/20110703235306/http://www.spastaff.com/" target="_blank">old look</a>
            to the version which is live today. The site is now responsive, and
            flicks into a "stretchy" design on small screens.
          </p>
          
          <p>
            In 2014, Spa Staff contracted a second freelance developer to
            perform petty bug fixes and improvements while I worked on a major
            site redesign. I was put in charge of training this developer in the
            technologies the site uses and assigning / overseeing jobs. This
            was my first experience of acting in a managerial role in a
            commercial group.
          </p>
          
          <footer>
            <div>
              <h3>Languages:</h3>
              <p>PHP, HTML5, CSS, JavaScript, SQL</p>
            </div>
            <div>
              <h3>Skills:</h3>
              <p>AWS Management, Client Management, Developer Training &amp; Management </p>
            </div>
            <div>
              <h3>APIs:</h3>
              <p>AWS PHP API, PayPal, Barclays Epdq</p>
            </div>
          </footer>
        </section>
        
        <section id="sweeb">
          <div class="pic_area">
            <img src="/images/sweeb.png" alt="SWEEB" />
          </div>
          <header>
            <h2>Sweeb</h2>
            <span class="position">Owner, Web Developer</span>
            <span class="dates">2005 - Present</span>
          </header>
          
          <p>
            I have been deeply interested in web development for a long time,
            and quickly realised that I could earn money from my passion. I act
            as a freelance web developer under the brand name: <span class="sweeb">SWEEB</span>.
          </p>
          
          <p>
            Many of my clients were small charities and individuals without
            any technical knowledge. This has taught me to be well versed in translating
            a user's functional requirements into a technical plan, and
            communicating with clients without resorting to confusing jargon.
          </p>
          
        </section>
        
        <section id="musicjobs">
          <div class="pic_area">
            <img src="/images/music_jobs.png" alt="Music Jobs Ltd" />
          </div>
          <header>
            <h2>Music Jobs</h2>
            <span class="position">Web Developer</span>
            <span class="dates">August 2010, July 2011</span>
          </header>
          <p>
            In the summer of 2010, I became an intern at their London office. My
            main task was reskinning their web site to look good on iPhones.
          </p>
          
          <p>
            In 2011 I was invited to their LA office, to continue as a Web
            Developer. I was tasked with rebuilding their payment systems.
          </p>

          <p>
            It was during my time at Music Jobs that I got my first taste of
            building mobile web apps, and running a site off Amazon Web
            Services' Elastic Cloud.
          </p>
        </section>
      </section>
      
      <!-- ///////////////////////////////////////////////////////// -->
      
      <section id="skills_section" class="band">
        <h1 id="skills">Skills</h1>
        
        <h2>Languages</h2>
        <div class="skillHolder">
          <div id="c">
            <span></span>
            C Programming
          </div>
          <div id="cpp">
            <span></span>
            C++
          </div>
          <div id="java">
            <span></span>
            Java
          </div>
          <div id="perl">
            <span></span>
            Perl
          </div>
          <div id="python">
            <span></span>
            Python
          </div>
          <div id="php">
            <span></span>
            PHP
          </div>
          <div id="html">
            <span></span>
            (X)HTML(5)
          </div>
          <div id="js">
            <span></span>
            JavaScript
          </div>
          <div id="css">
            <span></span>
            CSS(3)
          </div>
          <div id="sql">
            <span></span>
            SQL
          </div>
          <div id="bash">
            <span></span>
            BASH Scripting
          </div>
          <div id="scheme">
            <span></span>
            Scheme
          </div>
        </div>
        
        <h2>Systems</h2>
        <div class="skillHolder">
          <div id="gcp">
            <span></span>
            Google Cloud Platform
          </div>
          <div id="aws">
            <span></span>
            Amazon Web Services
          </div>
          <div id="apache">
            <span></span>
            Apache HTTP Server
          </div>
          <div id="linux">
            <span></span>
            Linux
          </div>
          <div id="mysql">
            <span></span>
            MySQL
          </div>
        </div>
        
        <h2>Software</h2>
        <div class="skillHolder">
          <div id="ps">
            <span></span>
            Photoshop
          </div>
          <div id="git">
            <span></span>
            Git
          </div>
          <div id="xampp">
            <span></span>
            XAMPP
          </div>
          <div id="putty">
            <span></span>
            PuTTY
          </div>
          <div id="winscp">
            <span></span>
            WinSCP
          </div>
        </div>
        
        <h2>APIs</h2>
        <div class="skillHolder">
          <div id="oauth">
            <span></span>
            OAuth
          </div>
          <div id="paypal">
            <span></span>
            PayPal
          </div>
          <div id="sagepay">
            <span></span>
            SagePay
          </div>
          <div id="braspag">
            <span></span>
            Braspag
          </div>
          <div id="epqd">
            <span></span>
            Barclays ePDQ
          </div>
        </div>
      </section>
      
      <section id="education_section">
        <div id="soton" class="parallax" data-parallax-scale="0.9">
          <h1 id="education">Education</h1>
          <section id="courses">
            <header>
              <h2 id="uni">University of Southampton</h2>
              <span>MEng, Computer Science</span>
            </header>

            <p>
              I am currently in my fourth year of an integrated Master of
              Engineering degree at the University of Southampton, reading Computer
              Science, on track for first class honours.
            </p>

            <div>Introduction to Formal Methods (COMP1001)</div>
            <div>Advanced Programming (COMP1003)</div>
            <div>Programming Principles (COMP1004)</div>
            <div>System Administration: Tools &amp; Techniques (COMP1005)</div>
            <div>Computer Architecture (COMP1006)</div>
            <div>Discrete Mathematics for Computer Science (COMP1007)</div>
            <div>Software Engineering (COMP1008)</div>
            <div>Data Structures &amp; Algorithms (COMP1009)</div>
            <div>Introduction to Digital Electronics (ELEC1013)</div>
            <div>Personal &amp; Professional Development (INFO1010)</div>
            <div>Engineering Mathematics for Computer Science (MATH1014)</div>
            <div>Computational Systems (COMP2002)</div>
            <div>Database Systems (COMP2004)</div>
            <div>Distributed Computing (COMP2005)</div>
            <div>Human-Computer Interaction (COMP2006)</div>
            <div>Software Analysis &amp; Design (COMP2007)</div>
            <div>Communications &amp; Networks (COMP2008)</div>
            <div>Operating Systems (COMP2009)</div>
            <div>Compiler Engineering (COMP2010)</div>
            <div>Theory of Computing (COMP2011)</div>
            <div>Software Engineering Project Work (COMP2012)</div>
            <div>Artificial Intelligence (COMP2039)</div>
            <div>Professional &amp; Legal Issues (INFO2009)</div>
            <div>Scripting Languages (COMP3001)</div>
            <div>Principles of Computer Graphics (COMP3004)</div>
            <div>Intelligence Algorithms (COMP3032)</div>
            <div>Cyber Security (COMP3201)</div>
            <div>Cloud Application Development (COMP3207)</div>
            <div>Advanced Databases (COMP3211)</div>
            <div>Principles and Practice of Computer Graphics (COMP3214)</div>
            <div>Engineering Management and Law (MANG3067)</div>
          </section>
        </div>
        <div id="theleys" class="parallax" data-parallax-scale="0.9">
          <section>
            <header>
              <h2>The Leys</h2>
              <span>Secondary School &amp; Sixth Form</span>
              
              <h3>A Levels</h3>
              Maths: A*, Further Maths: A*, Physics: A*, Chemistry: A
              
              <h3>GCSEs</h3>
              A*s in Maths, Biology, Physics, Chemistry, Divinity, Latin, English Literature<br />
              As in French, German, English Language, History
              
              <h3>FSMQ</h3>
              A in Additional Maths
            </header>
          </section>
        </div>
      </section>
      
      <!-- ///////////////////////////////////////////////////////// -->
      
      <section id="honors_section" class="band">
        <h1 id="awards">Honours and Awards</h1>
        
        <div class="items">
          <section>
            <h2>Netcraft Prize</h2>
            <p>
              For being in the top ten ranking students of the year 3
              cohort at the University of Southampton.
            </p>
          </section>

          <section>
            <h2>ECS Scholarship</h2>
            <p>
              For being in the top 10% of the year 2 cohort at the
              University of Southampton.
            </p>
          </section>

          <section>
            <h2>Zepler Scholarship</h2>
            <p>
              For being in the top 10% of the year 1 cohort at the
              University of Southampton.
            </p>
          </section>
          
          <section>
            <h2>University Scholarship Offer</h2>
            <p>
              Offered from the University of Birmingham as a result of
              a written test and interview.
            </p>
          </section>

          <section>
            <h2>Duke of Edinburugh</h2>
            <p>
              Completed up to a Gold Level.
            </p>
          </section>
          
          <section>
            <h2>Barnabus Award</h2>
            <p>
              For 'contributing to the building of community in The Leys
              School'. Nominated by fellow students.
            </p>
          </section>
        </div>
      </section>
      
      <!-- ///////////////////////////////////////////////////////// -->
      
      <section id="volunteering_section">
        <div id="nl_bg" class="parallax" data-parallax-scale="0.8">
          <h1 id="volunteering">Volunteering</h1>

          <section id="nightline">
            <img src="/images/nl.png" alt="Nightline" id="nl_logo" />

            <h2>Nightline</h2>

            <p>
              Southampton Nightline is a confidencial telephone listening service,
              run entirely by student volunteers availiable to anyone at
              the University of Southampton free of charge.
            </p>

            <p>
              I joined in 2013 and immediately recognised the importance
              of the service. I was one of the first volunteers in my
              cohort to reach the "experienced" level, allowing me to
              take calls, aid in training, and oversee others taking
              calls. In early 2014, I was awarded a prize for the most
              number of shifts covered.
            </p>

            <p>
              After only a year at Nightline, I became its head
              (the Nightline Officer) by entire-campus election. This put
              me in charge of all of Nightline's day to day operations,
              such as ensuring the rota was filled, charing the Nightline
              Committee, acting as a point of contact and support for
              our volunteers, and its longer term plans and strategies,
              such as managing the budget and refreshing our constitution
              and confidentiality policies.
            </p>

            <p>As
              call-taking volunteers are anonymous, the Nightline Officer
              is the only "public face" of the organise, meaning I was
              responsible for all of Nightline's public relations. This
              included: representing Nightline at meetings of the Students'
              Union and University, securing funds,
              heading up Nightline's social media presence and publicity
              events on campus, and liaising with the National Nightline
              Organisation.
            </p>
          </section>
        </div>
        
        <div id="susu_bg" class="parallax" data-parallax-scale="0.8">
          <section>
            <h2 id="susu">Student Representation</h2>
            
            <p>
              I became involved in student affairs very soon after
              settling in at university. Unofficially at first -
              emailing lecturers to provide feedback and pass on requests on
              behalf of my cohort. I quickly realised
              I was doing the job of a "course representative", so ran at the
              end of my second year, and won by a landslide.
            </p>
            
            <p>
              I was not a course rep long before I was promoted via
              whole campus election to the position of Faculty Officer,
              the highest student-held position in the representation
              system. This made me the head of student representation
              for my faculty, the Faculty of Physical Sciences and
              Engineering, covering the departments of Physics,
              Web Science, Optoelectronics and Electronics and Computer
              Science.
            </p>
            
            <p>
              Within the University, this position saw me attend meetings
              of senior lecturers and professors, to provide a student
              point of view on strategic decision within the faculty.
            </p>
          </section>
          
          <section>
            <h2>Students' Union</h2>
            <p>
              My role in representation introduced me to our Students' Union,
              <a href="http://www.susu.org/" target="_blank">SUSU</a>. After my
              time as Faculty Officer, I ran to be a Union Councillor, giving me
              a seat on the Union's highest decision making body. At these
              meetings, we oversaw the union's finances, discussed and voted on
              student-focused policies and decided stances for the entire union
              on issues such as the Lecturers' Marking Boycott.
            </p>
            
            <p></p>
          </section>
          
          <div id="susu_footer"></div>
        </div>
      </section>
      
      <!-- ///////////////////////////////////////////////////////// -->
      
      <section id="casual_section">
        <div id="walking" class="parallax" data-parallax-scale="0.7">
          <h1 id="casual">Casual Em</h1>

          <section>
            <h2>Walking</h2>
            <p>
              My preferred exercise is walking - at school I completed
              the Duke of Edinburugh Award at all three stages (Bronze,
              Silver and Gold). In fact, I enjoyed DofE so much that I
              volunteered with my school to help out their year eleven
              students, who were undertaking their Silver Award. This was
              an interesting and unique experience, as it gave me an
              insight into dealing with younger students in a position of
              legal authority.
            </p>

            <p>
              Since then, I have carried on with walking in my own time,
              going on repeated family holidays to places such as
              Snowdonia and the Lake District, and I have joined the
              walking society at my university.
            </p>
          </section>
        </div>
      </section>
    </main>
    
    <footer>
      <h1>Let's Stay In Touch...</h1>
      
      <div id="social_media">
        <a target="_blank" id="googleplus" href="https://plus.google.com/111629088428160104525/"><span></span>Google</a>
        <a target="_blank" id="fb" href="https://www.facebook.com/EmilyLangdonShepherd"><span></span>Facebook</a>
        <a target="_blank" id="twitter" href="https://twitter.com/EmilyLShepherd"><span></span>Twitter</a>
        <a target="_blank" id="linkedIn" href="https://uk.linkedin.com/pub/emily-shepherd/49/21a/57a"><span></span>LinkedIn</a>
        <a target="_blank" id="instagram" href="https://instagram.com/emilylshepherd/"><span></span>Instagram</a>
        <a target="_blank" id="github" href="https://github.com/EmilyShepherd"><span></span>Git Hub</a>
        <a target="_blank" id="gravatar" href="https://en.gravatar.com/stupidshep"><span></span>Gravatar</a>
        <a target="_blank" id="keybase" href="https://keybase.io/emilyshepherd"><span></span>Keybase</a>
        <a target="_blank" id="email" href="mailto:emily@emilyshepherd.me"><span></span>Email</a>
        <a target="_blank" id="pgp" href="<?=$asc?>"><span></span>PGP Key</a>
      </div>
            
      <small>
        <!-- Funny joke in 3, 2, 1... -->
        Page Transmitted via
        <a target="_blank" href="https://tools.ietf.org/html/rfc1149">IPoAC</a><br />
        Database stack image by <a target="_blank" href="http://barrymieny.deviantart.com/">Barry Mieny</a>,
        with <a href="https://creativecommons.org/licenses/by-nc-sa/3.0/" target="_blank">CC BY-NC-SA 3.0</a> license.
      </small>
    </footer>
    
    <div id="pgp_popup">
      <a href="javascript:closePopup();" id="pgp_close">X</a>
      <h1>PGP Public Key</h1>
      
      <br />
      
      <span class="label">Fingerprint</span>
      4C8D 7CBA A377 7A9B B0C3 F6FC A91F 7111 D9AF 0B5D
      
      <br /><br />
      
      <span class="label">Key</span><br />
      <a href="/<?=$asc?>" target="_blank">Download Raw .asc file</a> |
      <a href="javascript:copy();">Copy to Clipboard</a>
      <span id="copy_conf">Copied</span>
      <div>
        <textarea id="pgp_text"></textarea>
      </div>
    </div>
    
    <script>
      window.ascLocation = '/<?=$asc?>';
    </script>
    
    <!-- Start loading scripts -->
    <!-- At the end so the page can load first -->
    <script src="/<?=$js?>"></script>
    
    <script>
      (new Em.Parallax({"wCutOff" : 780 })).registerListener();
      (new Em.Parallax({"wCutOff" : 780, "className" : "parallax2", "style" : "top" })).registerListener();
    </script>
    
    <!-- Analytics -->
    <script>
      (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
      (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
      m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
      })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

      ga('create', 'UA-22782962-2', 'auto');
      ga('send', 'pageview');
    </script>
    
    <!-- Google Markup -->
    <script type="application/ld+json">
      {
        "@context" : "http://schema.org",
        "@type" : "Person",
        "name" : "Emily Shepherd",
        "url" : "http://emilyshepherd.me",
        "sameAs" : [
          "https://plus.google.com/111629088428160104525/",
          "https://www.facebook.com/EmilyLangdonShepherd",
          "https://uk.linkedin.com/pub/emily-shepherd/49/21a/57a",
          "https://twitter.com/EmilyLShepherd"
        ]
      }
    </script>
  </body>
</html>
<?php
$content = ob_get_contents();
ob_end_clean();

$content = preg_replace('/<!--(.*?)-->/', '', $content);
$content = preg_replace('/[\r\n]/', ' ', $content);
$content = preg_replace('/ +/', ' ', $content);
$content = preg_replace('/((?<=[^:]) (?=<[^a]))|((?<=[^a]>) )|( (?=\/>))/', '', $content);
$content = preg_replace('/(?<=<\/a>) (?=<)|(?<=>) (?=<a\/>)/', '', $content);
$content = preg_replace_callback('/<script.*?>.*?<\/script>/',
    (function($matches)
    {
        return preg_replace('/(?<=[:,{}\(\)\[\]]) | (?=[:,{}\(\)\[\]])/', '', $matches[0]);
    }), $content);

$etag = md5($content);

if (isset($_SERVER['HTTP_IF_NONE_MATCH']) && $_SERVER['HTTP_IF_NONE_MATCH'] === $etag)
{
    header('HTTP/1.1 304 Not Modified');
    exit;
}

header('ETag: ' . $etag);

if (strpos($_SERVER['HTTP_ACCEPT_ENCODING'], 'gzip') !== false)
{
    header('Content-Encoding: gzip');
    $content = gzencode($content);
}

header('Content-Length: ' . strlen($content));

echo $content;
flush();