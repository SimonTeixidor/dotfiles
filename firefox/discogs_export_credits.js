// ==UserScript==
// @name        Copy Discogs Credits
// @namespace   https://www.discogs.com
// @include     https://www.discogs.com/*/release/*
// @version     1
// ==/UserScript==

const label = document.createElement("input");
label.type = "button";
label.value = "Copy To Clipboard";
label.onclick = copy_tags;
label.style = "float: right";
document.querySelector("#credits h3").appendChild(label);

function copy_tags() {
        const credits = Array.from(document.querySelectorAll("#credits li"))
                .flatMap(n => {
                        const childNodes = Array.from(n.childNodes)
                                .filter(n => n.nodeName === "A" || n.nodeName === "SPAN")
                                .map(n => n.innerText);
                        const role = childNodes[0];
                        return childNodes.slice(1).map(n => [role, n]);
                });

        const performer_roles = [
                "sax", "guitar", "trumpet", "violin", "vocals", "wind", "tuba",
                "trombone", "timbales", "tambourine", "synth", "vibraphone", "reeds",
                "piano", "oud", "organ", "oboe", "percussion", "keyboard",
                "horn", "harmonica", "flute", "drums", "congas", "clarinet",
                "cello", "brass", "bass", "accordion", "choir", "viola", "chorus master",
		"dulcian", "harp", "lute", "sackbut", "violone", "theorbo", "viol"
        ];

        const ignored_roles = [
                "design", "producer", "compose", "liner", "illustration", "cover"
        ];

        const engineer_roles = [
                "engineer", "recorder", "mastered", "recorded"
        ];

        const mixer_roles = [
                "mixed", "mixing", "mixer"
        ];
  
        const conductor_roles = [
                "conductor", "conducted"
        ];
  
        const ensemble_roles = [
                "ensemble", "orchestra"
        ];
  			
	const lyricist_roles = [
          "lyricist", "text by"
        ];
 
	const arranger_roles = [
          "arranged"
        ];

        const any_of = list => elem => list.some(m => elem.toLowerCase().includes(m.toLowerCase()));
        const is_performer = any_of(performer_roles);
        const is_ignored = any_of(ignored_roles);
        const is_engineer = any_of(engineer_roles);
        const is_mixer = any_of(mixer_roles);
        const is_conductor = any_of(conductor_roles);
        const is_ensemble = any_of(ensemble_roles);
	const is_lyricist = any_of(lyricist_roles);
	const is_arranger = any_of(arranger_roles);


        const create_tag = (role, name) => {
                if(is_performer(role)) {
                        return `PERFORMER=${name} (${role})`;
                } else if (is_engineer(role)) {
                        return `ENGINEER=${name}`;
                } else if (is_mixer(role)) {
                        return `MIXER=${name}`;
                } else if (is_conductor(role)) {
                        return `CONDUCTOR=${name}`;
                } else if (is_ensemble(role)) {
                        return `ENSEMBLE=${name}`;
                } else if (is_lyricist(role)) {
                        return `LYRICIST=${name}`;
                } else if (is_arranger(role)) {
                        return `ARRANGER=${name}`;
                } else if (!is_ignored(role)) {
                        window.alert(`Unhandled role ${role}`);
                }
        }

        const tags = credits.map(a => create_tag(a[0], a[1])).filter(t => t !== undefined);
        const tag_string = tags.join("\n");

        const output_element = document.createElement("span");
        output_element.innerText = tag_string;
        document.querySelector("#credits").appendChild(output_element);
}

