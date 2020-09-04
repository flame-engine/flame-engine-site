import React from "react"

import { PageWrapper } from "../components/Page"
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome"
import { faGithub, faTwitter, faMeetup, faYoutube } from "@fortawesome/free-brands-svg-icons"

import "./flameconTemplate.css"

const Spacer = ({ height }) => <div style={{ height }} />

export default function Template() {
  return (
    <PageWrapper title="Flamecon" fullWitdh={true}>
      <div className="flamecon-wrapper">
        <div className="flamecon-inner">
          <Spacer height="5%" />
          <p className="firealistic">flutter game engine conference</p>
          <Spacer height="10%" />
          <p className="firealistic flamecon-title">FLAMECON</p>
          <Spacer height="10%" />
          <div className="flamecon-block">
            <p className="firealistic">Building RPG games with</p>
            <p className="firealistic flamecon-stripe">
              <a href="https://bonfire-engine.github.io/">Bonfire</a>
              &nbsp;
              <a href="https://github.com/RafaelBarbosatec/bonfire">
                <FontAwesomeIcon icon={faGithub} />
              </a>
            </p>
            <p className="firealistic flamecon-small">
              <span>by Rafael Barbosa</span>
              &nbsp;
              <a href="https://github.com/RafaelBarbosatec">
                <FontAwesomeIcon icon={faGithub} />
              </a>
              &nbsp;
              <a href="https://twitter.com/RafaBarbosaTec">
                <FontAwesomeIcon icon={faTwitter} />
              </a>
            </p>
          </div>
          <Spacer height="10%" />
          <div className="flamecon-block">
            <p className="firealistic">Optimizing sprite usage with</p>
            <p className="firealistic flamecon-stripe">
              <a href="https://fire-atlas.flame-engine.org/">Fire Atlas</a>
              &nbsp;
              <a href="https://github.com/flame-engine/fire-atlas">
                <FontAwesomeIcon icon={faGithub} />
              </a>
            </p>
            <p className="firealistic flamecon-small">
              <span>by Erick Zanardo</span>
              &nbsp;
              <a href="https://github.com/erickzanardo">
                <FontAwesomeIcon icon={faGithub} />
              </a>
              &nbsp;
              <a href="https://twitter.com/CptPixel">
                <FontAwesomeIcon icon={faTwitter} />
              </a>
            </p>
          </div>
          <Spacer height="10%" />
          <div className="firealistic">join us at:</div>
          <div className="firealistic">
            <a href="https://www.meetup.com/FlameCon/">
              <FontAwesomeIcon icon={faMeetup} />
            </a>
            &nbsp;
            <a href="https://www.youtube.com/channel/UCinjCGNThGXbUYFgfgsI0bA">
              <FontAwesomeIcon icon={faYoutube} />
            </a>
          </div>
          <div className="flamecon-footer">
            <div className="flamecon-two-cols">
              <p>16 SEPT</p>
              <p>20:00 UTC</p>
            </div>
          </div>
        </div>
      </div>
    </PageWrapper>
  )
}
