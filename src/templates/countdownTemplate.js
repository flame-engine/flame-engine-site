import React, { useState, useEffect } from "react"

import { PageWrapper } from "../components/Page"
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome"
import { faFire } from "@fortawesome/free-solid-svg-icons"

import "./countdown.css"

const now = () => new Date().getTime()

export default function Template() {
  const SEC_IN_MILLIS = 1000
  const MIN_IN_SEC = 60

  const [currentTime, setCurrent] = useState(null)
  const [targetTime, setTarget] = useState(null)

  useEffect(() => {
    const urlParams = new URLSearchParams(window.location.search)
    const currentTimestamp = now()
    const tMinus = urlParams.get("tminus")
    const targetTimestamp = tMinus
      ? currentTimestamp + tMinus * SEC_IN_MILLIS
      : urlParams.get("timestamp") || currentTimestamp
    console.log(targetTimestamp)
    setCurrent(currentTimestamp)
    setTarget(targetTimestamp)
  }, [])

  useEffect(() => {
    if (currentTime) {
      setTimeout(() => setCurrent(now()), SEC_IN_MILLIS)
    }
  }, [currentTime])

  const seconds = num =>
    `${Math.abs(Math.round(num % MIN_IN_SEC))}`.padStart(2, "0")
  const minutes = num => Math.floor(num / MIN_IN_SEC)
  const format = num =>
    num && num > 0 ? `${minutes(num)}:${seconds(num)}` : "-"

  const delta = Math.round((targetTime - currentTime) / SEC_IN_MILLIS)
  return (
    <PageWrapper title="Countdown" fullWitdh={true}>
      <div className="flame-logo-wrapper">
        <div className="flame-logo-inner countdown">
          <FontAwesomeIcon icon={faFire}></FontAwesomeIcon>
          <p>{format(delta)}</p>
        </div>
      </div>
    </PageWrapper>
  )
}
