import React, { useEffect } from "react"

export default url =>
  /**
   * @return {null}
   */
  function Redirect() {
    useEffect(() => {
      window.location.replace(url)
    })
    return null
  }
