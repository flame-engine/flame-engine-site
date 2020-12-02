import React, { useEffect, useState } from "react"

import { PageWrapper } from "../components/Page"
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome"
import {
  faGithub,
  faMeetup,
  faYoutube,
  faDiscord,
} from "@fortawesome/free-brands-svg-icons"
import { PaperTooltip } from "../components/Tooltip"

import "./flamecon.css"

export default function Template() {
  const [localTime, setLocalTime] = useState(null)

  useEffect(() => {
    const theDate = new Date(Date.UTC(2020, 11, 9, 20, 0))
    const formatter = new Intl.DateTimeFormat(navigator.language, {
      hour: "numeric",
      minute: "numeric",
    })
    setLocalTime(formatter.format(theDate))
  })

  const time = localTime ? (
    <PaperTooltip
      position={2}
      relation="top"
      content={
        <p className="flamecon-localtime">This is {localTime} for you</p>
      }
    >
      {setShow => (
        <b
          onMouseEnter={() => setShow(true)}
          onMouseLeave={() => setShow(false)}
          className="flamecon-utc"
          title={`This is ${localTime} for you`}
        >
          8PM UTC
        </b>
      )}
    </PaperTooltip>
  ) : (
    <b className="flamecon-utc">8PM UTC</b>
  )

  return (
    <PageWrapper
      title="Flamecon - Flame engine online conference"
      fullWitdh={true}
      hideFlameconBanner
    >
      <div className="flame-logo-wrapper">
        <div className="flame-logo-inner">
          <h1 className="flamecon-title">FLAMECON II</h1>
          <div className="flamecon-tagline">Flutter game engine conference</div>
          <div className="flamecon-lineup">
            <p className="flamecon-datetime">
              <b>9 Dec</b> at {time}:
            </p>
            <div className="flamecon-talk">
              Introduction to the&nbsp;
              <a
                className="flamecon-boom"
                title="Effects API"
              >
                Effects API
              </a>
              <a href="https://github.com/spydon">
                <FontAwesomeIcon icon={faGithub} />
              </a>
              <a
                className="flamecon-author"
                href="https://lukas.fyi/"
                target="_blank"
              >
                Lukas Klingsbo
              </a>
            </div>
            <div className="flamecon-talk">
              Pseudo-3D&nbsp;
              <a
                className="flamecon-boom"
                title="Dungeon Tiles"
              >
                Dungeon Tiles&nbsp;
              </a>
              in Flame
              <a
                className="flamecon-author"
                href="https://twitter.com/MissionCTRLGame"
                target="_blank"
              >
                David Donze
              </a>
            </div>
          </div>

          <p className="flamecon-join">
            Join us at:{" "}
            <a href="https://www.meetup.com/FlameCon/events/273073483/">
              <FontAwesomeIcon icon={faMeetup} />
            </a>{" "}
            <a href="https://www.youtube.com/channel/UCinjCGNThGXbUYFgfgsI0bA">
              <FontAwesomeIcon icon={faYoutube} />
            </a>{" "}
            <a href="https://discord.gg/s2qHSYT">
              <FontAwesomeIcon icon={faDiscord} />
            </a>
          </p>
          <a
            className="flamecon-cta"
            target="_blank"
            href="http://www.google.com/calendar/event?action=TEMPLATE&dates=20201209T200000Z%2F20200916T220000Z&text=Flamecon%20II&location=&details=Second%20iteration%20of%20FlameCon%2C%20an%20open%2C%20online%20community%20event%20to%20gather%20people%20that%20use%20and%20love%20Flame%2C%20the%20Flutter%20game%20engine.%0A%0AMore%20details%3A%20http%3A%2F%2Fflame-engine.org%2Fflamecon"
          >
            Save the date
          </a>
        </div>
      </div>
    </PageWrapper>
  )
}
